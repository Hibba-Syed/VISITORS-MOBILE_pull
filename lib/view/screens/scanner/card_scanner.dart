import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../../utils/app_utils.dart';
import '../../widgets/button/custom_button.dart';

class CardScanner extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CardScanner({super.key, required this.cameras});

  @override
  State<CardScanner> createState() => _CardScannerState();
}

class _CardScannerState extends State<CardScanner> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCardDetected = false;
  bool _isImageClear = false;
  bool _autoCapture = true;
  String _message = AppUtils.languageTranslate('positionCardWithinFrame');

  Timer? _detectionTimer;
  Uint8List? _capturedImage;
  File? _capturedImageFile;
  bool _isCapturing = false;
  int _stableFrameCount = 0;
  static const int _requiredStableFrames = 3;
  bool _captureTriggered = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isEmpty) {
      setState(() => _message = AppUtils.languageTranslate('noCameraFound'));
      return;
    }

    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _controller!.initialize();
      await _controller!.setFlashMode(FlashMode.off);
      setState(() => _isInitialized = true);
      _startDetection();
    } catch (e) {
      setState(() => _message =
          '${AppUtils.languageTranslate('cameraError')} ${e.toString()}');
    }
  }

  void _startDetection() {
    _detectionTimer?.cancel();
    _captureTriggered = false;
    _detectionTimer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        if (_capturedImage != null || !mounted || _isCapturing) {
          timer.cancel();
          return;
        }
        _detectCard();
      },
    );
  }

  Future<void> _detectCard() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isCapturing ||
        _capturedImage != null ||
        _captureTriggered) {
      return;
    }

    try {
      final image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null || !mounted) return;

      final croppedImage = _getCroppedFrame(decodedImage);

      final hasContent = _checkContentPresence(croppedImage);
      final cardPresent = _checkCardPresence(croppedImage);
      final imageClear = _checkImageClarity(croppedImage);
      final cardFillsFrame = _checkCardFillsFrame(croppedImage);

      final allConditionsMet =
          hasContent && cardPresent && imageClear && cardFillsFrame;

      if (allConditionsMet) {
        _stableFrameCount++;
      } else {
        _stableFrameCount = 0;
      }

      if (mounted && !_captureTriggered) {
        setState(() {
          _isCardDetected = hasContent && cardPresent && cardFillsFrame;
          _isImageClear = imageClear;

          if (allConditionsMet && _stableFrameCount >= _requiredStableFrames) {
            _message = AppUtils.languageTranslate('cardDetectedHoldSteady');

            if (_autoCapture && !_captureTriggered) {
              _captureTriggered = true;
              _detectionTimer?.cancel();
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted && _capturedImage == null) {
                  _captureImage();
                }
              });
            }
          } else if (cardPresent && !imageClear) {
            _message = AppUtils.languageTranslate('imageBlurryHoldSteady');
          } else if (cardPresent && !cardFillsFrame) {
            _message =
                AppUtils.languageTranslate('moveCardInsideFrameCompletely');
          } else {
            _message = AppUtils.languageTranslate('positionCardWithinFrame');
          }
        });
      }
    } catch (e) {
      debugPrint('Detection error: $e');
    }
  }

  img.Image _getCroppedFrame(img.Image decodedImage) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final frameWidthRatio = isTablet ? 0.55 : 0.80;

    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final uiFrameWidth = screenWidth * frameWidthRatio;
    final uiFrameHeight = uiFrameWidth / 1.586;

    final cameraRatio = _controller!.value.aspectRatio;
    final screenAspect = screenHeight / screenWidth;

    double scaleX, scaleY;
    if (screenAspect > cameraRatio) {
      final previewWidth = screenHeight / cameraRatio;
      scaleX = decodedImage.width / previewWidth;
      scaleY = decodedImage.height / screenHeight;
    } else {
      final previewHeight = screenWidth * cameraRatio;
      scaleX = decodedImage.width / screenWidth;
      scaleY = decodedImage.height / previewHeight;
    }

    final frameWidth = (uiFrameWidth * scaleX).toInt();
    final frameHeight = (uiFrameHeight * scaleY).toInt();
    final frameX = ((decodedImage.width - frameWidth) / 2).toInt();
    final frameY = ((decodedImage.height - frameHeight) / 2).toInt();

    return img.copyCrop(decodedImage,
        x: frameX, y: frameY, width: frameWidth, height: frameHeight);
  }

  bool _checkContentPresence(img.Image image) {
    int totalLuminance = 0;
    int samples = 0;
    List<int> luminanceValues = [];

    for (int y = 10; y < image.height - 10; y += 15) {
      for (int x = 10; x < image.width - 10; x += 15) {
        final pixel = image.getPixel(x, y);
        final lum = _getLuminance(pixel).toInt();
        luminanceValues.add(lum);
        totalLuminance += lum;
        samples++;
      }
    }

    if (samples == 0) return false;

    final mean = totalLuminance / samples;
    double variance = 0;
    for (var lum in luminanceValues) {
      variance += (lum - mean) * (lum - mean);
    }
    variance /= samples;

    int colorVariation = 0;
    for (int y = 10; y < image.height - 10; y += 20) {
      for (int x = 10; x < image.width - 10; x += 20) {
        if (x + 20 < image.width - 10 && y + 20 < image.height - 10) {
          final p1 = image.getPixel(x, y);
          final p2 = image.getPixel(x + 20, y + 20);

          final rDiff = (p1.r - p2.r).abs();
          final gDiff = (p1.g - p2.g).abs();
          final bDiff = (p1.b - p2.b).abs();

          if (rDiff > 20 || gDiff > 20 || bDiff > 20) {
            colorVariation++;
          }
        }
      }
    }

    return variance > 350 && colorVariation > 12;
  }

  bool _checkCardPresence(img.Image image) {
    int strongEdges = 0;
    int texturePoints = 0;

    for (int y = 8; y < image.height - 8; y += 8) {
      for (int x = 8; x < image.width - 8; x += 8) {
        final center = image.getPixel(x, y);
        final right = image.getPixel(x + 8, y);
        final bottom = image.getPixel(x, y + 8);

        final lumC = _getLuminance(center);
        final lumR = _getLuminance(right);
        final lumB = _getLuminance(bottom);

        final edgeH = (lumC - lumR).abs();
        final edgeV = (lumC - lumB).abs();
        final maxEdge = edgeH > edgeV ? edgeH : edgeV;

        if (maxEdge > 60) strongEdges++;
        if (maxEdge > 25) texturePoints++;
      }
    }

    return strongEdges > 20 && texturePoints > 100;
  }

  bool _checkCardFillsFrame(img.Image image) {
    const margin = 35;
    int marginEdges = 0;
    int marginSamples = 0;

    // Check top and bottom margins
    for (int x = margin; x < image.width - margin; x += 10) {
      if (20 < margin && image.height - 8 > 0) {
        final p1 = image.getPixel(x, 8);
        final p2 = image.getPixel(x, 20);
        if (((_getLuminance(p1) - _getLuminance(p2)).abs() > 40)) marginEdges++;
        marginSamples++;

        final p3 = image.getPixel(x, image.height - 20);
        final p4 = image.getPixel(x, image.height - 8);
        if (((_getLuminance(p3) - _getLuminance(p4)).abs() > 40)) marginEdges++;
        marginSamples++;
      }
    }

    // Check left and right margins
    for (int y = margin; y < image.height - margin; y += 10) {
      if (20 < margin && image.width - 8 > 0) {
        final p1 = image.getPixel(8, y);
        final p2 = image.getPixel(20, y);
        if (((_getLuminance(p1) - _getLuminance(p2)).abs() > 40)) marginEdges++;
        marginSamples++;

        final p3 = image.getPixel(image.width - 20, y);
        final p4 = image.getPixel(image.width - 8, y);
        if (((_getLuminance(p3) - _getLuminance(p4)).abs() > 40)) marginEdges++;
        marginSamples++;
      }
    }

    if (marginSamples == 0) return false;
    final marginEdgeRatio = marginEdges / marginSamples;

    // Check inner area
    int innerEdges = 0;
    int innerSamples = 0;
    for (int y = margin + 15; y < image.height - margin - 15; y += 12) {
      for (int x = margin + 15; x < image.width - margin - 15; x += 12) {
        if (x + 8 < image.width - margin && y + 8 < image.height - margin) {
          final p1 = image.getPixel(x, y);
          final p2 = image.getPixel(x + 8, y);
          if (((_getLuminance(p1) - _getLuminance(p2)).abs() > 30)) {
            innerEdges++;
          }
          innerSamples++;
        }
      }
    }

    final innerEdgeRatio = innerSamples > 0 ? innerEdges / innerSamples : 0;
    return marginEdgeRatio < 0.10 && innerEdgeRatio > 0.10;
  }

  bool _checkImageClarity(img.Image image) {
    double laplacianSum = 0;
    int sampleCount = 0;

    for (int y = 3; y < image.height - 3; y += 4) {
      for (int x = 3; x < image.width - 3; x += 4) {
        final center = _getLuminance(image.getPixel(x, y));
        final top = _getLuminance(image.getPixel(x, y - 3));
        final bottom = _getLuminance(image.getPixel(x, y + 3));
        final left = _getLuminance(image.getPixel(x - 3, y));
        final right = _getLuminance(image.getPixel(x + 3, y));

        final laplacian = (4 * center - top - bottom - left - right).abs();
        laplacianSum += laplacian;
        sampleCount++;
      }
    }

    final variance = laplacianSum / sampleCount;
    return variance > 12;
  }

  double _getLuminance(img.Pixel pixel) {
    return 0.299 * pixel.r + 0.587 * pixel.g + 0.114 * pixel.b;
  }

  Future<void> _captureImage() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isCapturing ||
        _capturedImage != null) {
      return;
    }

    setState(() => _isCapturing = true);
    _detectionTimer?.cancel();

    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null) {
        setState(() => _isCapturing = false);
        _startDetection();
        return;
      }

      final croppedImage = _getCroppedFrame(decodedImage);
      final jpegBytes =
          Uint8List.fromList(img.encodeJpg(croppedImage, quality: 90));

      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          '${directory.path}/card_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(jpegBytes);

      if (mounted) {
        setState(() {
          _capturedImage = jpegBytes;
          _capturedImageFile = imageFile;
          _message = AppUtils.languageTranslate('imageCapturedSuccessfully');
          _isCapturing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _message =
              '${AppUtils.languageTranslate('captureError')} ${e.toString()}';
          _isCapturing = false;
        });
      }
      _startDetection();
    }
  }

  void _retakePhoto() {
    if (_capturedImageFile != null && _capturedImageFile!.existsSync()) {
      try {
        _capturedImageFile!.deleteSync();
      } catch (e) {
        debugPrint('Error deleting file: $e');
      }
    }
    setState(() {
      _capturedImage = null;
      _capturedImageFile = null;
      _message = AppUtils.languageTranslate('positionCardWithinFrame');
      _stableFrameCount = 0;
      _isCapturing = false;
      _captureTriggered = false;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _startDetection();
    });
  }

  @override
  void dispose() {
    _detectionTimer?.cancel();
    _controller?.dispose();
    if (_capturedImageFile != null && _capturedImageFile!.existsSync()) {
      try {
        _capturedImageFile!.deleteSync();
      } catch (e) {
        debugPrint('Error deleting file on dispose: $e');
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_capturedImage != null) return _buildCaptureResult();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isInitialized
            ? _buildCameraView()
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildCameraView() {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    final frameWidthRatio = isTablet ? 0.55 : 0.80;

    return Stack(
      children: [
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: size.width,
              height: size.width * _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
          ),
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.6),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  width: size.width * frameWidthRatio,
                  height: (size.width * frameWidthRatio) / 1.586,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          AppUtils.languageTranslate('idCardScanner'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          AppUtils.languageTranslate('auto'),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Switch(
                          value: _autoCapture,
                          onChanged: (value) {
                            setState(() {
                              _autoCapture = value;
                              _captureTriggered = false;
                            });
                          },
                          activeThumbColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      (_isCardDetected &&
                              _isImageClear &&
                              _stableFrameCount >= _requiredStableFrames)
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: (_isCardDetected &&
                              _isImageClear &&
                              _stableFrameCount >= _requiredStableFrames)
                          ? Colors.green
                          : Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(child: _buildFrameOverlay(frameWidthRatio)),
        Positioned(
          bottom: _autoCapture ? 16 : 96,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusIndicator(
                    AppUtils.languageTranslate("cardDetected"),
                    _isCardDetected),
                _buildStatusIndicator(
                    AppUtils.languageTranslate('imageClear'), _isImageClear),
              ],
            ),
          ),
        ),
        if (!_autoCapture)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (_isCardDetected &&
                      _isImageClear &&
                      _stableFrameCount >= _requiredStableFrames &&
                      !_isCapturing) {
                    _captureTriggered = true;
                    _captureImage();
                  }
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: (_isCardDetected &&
                            _isImageClear &&
                            _stableFrameCount >= _requiredStableFrames &&
                            !_isCapturing)
                        ? Colors.white
                        : Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: _isCapturing
                        ? const CircularProgressIndicator(strokeWidth: 3)
                        : Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (_isCardDetected &&
                                        _isImageClear &&
                                        _stableFrameCount >=
                                            _requiredStableFrames)
                                    ? Colors.blue
                                    : Colors.grey.shade500,
                                width: 3,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFrameOverlay(double frameWidthRatio) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * frameWidthRatio;
    final cardHeight = cardWidth / 1.586;

    final isReady = _isCardDetected &&
        _isImageClear &&
        _stableFrameCount >= _requiredStableFrames;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: isReady
              ? Colors.green
              : _isCardDetected
                  ? Colors.yellow
                  : Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                (isReady ? Colors.green : Colors.white).withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildCorner(Alignment.topLeft, true, true, isReady),
          _buildCorner(Alignment.topRight, true, false, isReady),
          _buildCorner(Alignment.bottomLeft, false, true, isReady),
          _buildCorner(Alignment.bottomRight, false, false, isReady),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                AppUtils.languageTranslate('alignCardHere'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment, bool top, bool left, bool isReady) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white, width: 4)
                : BorderSide.none,
            bottom: !top
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white, width: 4)
                : BorderSide.none,
            left: left
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white, width: 4)
                : BorderSide.none,
            right: !left
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.grey,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildCaptureResult() {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          AppUtils.languageTranslate('captureSuccessful'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(_capturedImage!),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: AppUtils.languageTranslate('retakePhoto'),
                            onPressed: _retakePhoto,
                            invert: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text:
                                AppUtils.languageTranslate('confirmAndUpload'),
                            onPressed: () =>
                                Navigator.pop(context, _capturedImageFile),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
