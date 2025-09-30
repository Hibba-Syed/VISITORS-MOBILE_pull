import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;

class IdScannerGpt extends StatefulWidget {
  const IdScannerGpt({Key? key}) : super(key: key);

  @override
  State<IdScannerGpt> createState() => _IdScannerGptState();
}

class _IdScannerGptState extends State<IdScannerGpt> {
  CameraController? _controller;
  bool _isProcessing = false;
  Timer? _throttleTimer;
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  // ID card aspect ratio (85.6 × 54 mm ≈ 1.585:1)
  final double overlayRatio = 1.585;

  int _goodFrameCount = 0;
  final int requiredGoodFrames = 2;

  // thresholds
  final double minCoveragePercent = 0.4;
  final double maxCenterOffsetPercent = 0.2;
  final double blurThreshold = 80.0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );
    _controller =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);

    await _controller!.initialize();
    await _controller!.startImageStream(_processCameraImage);
    if (mounted) setState(() {});
  }

  Future<void> _processCameraImage(CameraImage cameraImage) async {
    if (_isProcessing) return;
    if (_throttleTimer?.isActive ?? false) return;
    _throttleTimer = Timer(const Duration(milliseconds: 500), () {});
    _isProcessing = true;

    try {
      final inputImage = _convertCameraImage(
          cameraImage, _controller!.description.sensorOrientation);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      // Find largest block
      Rect? candidateRect;
      double largestArea = 0;
      for (final block in recognizedText.blocks) {
        final box = block.boundingBox;
        if (box != null) {
          final area = box.width * box.height;
          if (area > largestArea) {
            largestArea = area;
            candidateRect = box;
          }
        }
      }

      final imageWidth = inputImage.metadata!.size.width;
      final imageHeight = inputImage.metadata!.size.height;

      // overlay rect
      final overlayWidth = imageWidth * 0.8;
      final overlayHeight = overlayWidth / overlayRatio;
      final overlayLeft = (imageWidth - overlayWidth) / 2;
      final overlayTop = (imageHeight - overlayHeight) / 2;
      final overlayRect =
          Rect.fromLTWH(overlayLeft, overlayTop, overlayWidth, overlayHeight);

      bool aligned = false;
      bool coverageOk = false;
      bool sharp = false;

      if (candidateRect != null) {
        final candidateCenter = candidateRect.center;
        final overlayCenter = overlayRect.center;
        final dx =
            (candidateCenter.dx - overlayCenter.dx).abs() / overlayRect.width;
        final dy =
            (candidateCenter.dy - overlayCenter.dy).abs() / overlayRect.height;
        aligned = dx <= maxCenterOffsetPercent && dy <= maxCenterOffsetPercent;

        final overlayArea = overlayRect.width * overlayRect.height;
        final coverage =
            (candidateRect.width * candidateRect.height) / overlayArea;
        coverageOk = coverage >= minCoveragePercent;
      }

      final variance = await computeLaplacianVariance(cameraImage);
      sharp = variance >= blurThreshold;

      if (aligned && coverageOk && sharp) {
        _goodFrameCount++;
      } else {
        _goodFrameCount = 0;
      }

      if (_goodFrameCount >= requiredGoodFrames) {
        await _capturePhoto();
        _goodFrameCount = 0;
      }
    } catch (_) {
      // ignore
    } finally {
      _isProcessing = false;
    }
  }

  InputImage _convertCameraImage(CameraImage image, int rotation) {
    final ui.WriteBuffer allBytes = ui.WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final InputImageRotation imageRotation =
        InputImageRotationValue.fromRawValue(rotation) ??
            InputImageRotation.rotation0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  Future<double> computeLaplacianVariance(CameraImage image) async {
    try {
      final plane = image.planes.first; // Y plane
      final bytes = plane.bytes;
      final width = image.width;
      final height = image.height;

      const step = 8;
      final smallW = (width / step).floor();
      final smallH = (height / step).floor();
      final gray = img.Image(width: smallW, height: smallH);

      for (int y = 0; y < smallH; y++) {
        for (int x = 0; x < smallW; x++) {
          final srcX = x * step;
          final srcY = y * step;
          final pixel = bytes[srcY * plane.bytesPerRow + srcX];
          gray.setPixelRgb(x, y, pixel, pixel, pixel);
        }
      }

      final kernel = [
        0,
        1,
        0,
        1,
        -4,
        1,
        0,
        1,
        0,
      ];
      final lap = img.convolution(gray, filter: kernel, div: 3, offset: 3);

      final pixels = lap.getBytes();
      double sum = 0, sumSq = 0;
      final total = pixels.length;
      for (int i = 0; i < total; i++) {
        final v = pixels[i].toDouble();
        sum += v;
        sumSq += v * v;
      }
      final mean = sum / total;
      final variance = (sumSq / total) - (mean * mean);
      return variance.isFinite ? variance : 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      final XFile file = await _controller!.takePicture();
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CapturedPreview(path: file.path),
        ),
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textRecognizer.close();
    _throttleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final size = MediaQuery.of(context).size;
    final previewSize = _controller!.value.previewSize!;
    final scale = size.aspectRatio / (previewSize.height / previewSize.width);

    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
            scale: scale,
            child: Center(child: CameraPreview(_controller!)),
          ),
          _buildOverlay(context),
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final overlayWidth = constraints.maxWidth * 0.8;
      final overlayHeight = overlayWidth / overlayRatio;
      final left = (constraints.maxWidth - overlayWidth) / 2;
      final top = (constraints.maxHeight - overlayHeight) / 2;

      return Stack(children: [
        Positioned(
          left: left,
          top: top,
          width: overlayWidth,
          height: overlayHeight,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Column(
            children: [
              const Text(
                "Fit the ID card inside the frame",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _capturePhoto,
                child: const Text("Capture Manually"),
              ),
            ],
          ),
        ),
      ]);
    });
  }
}

class CapturedPreview extends StatelessWidget {
  final String path;
  const CapturedPreview({required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Captured")),
      body: Center(child: Image.file(File(path))),
    );
  }
}
