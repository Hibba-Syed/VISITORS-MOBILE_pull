import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class IDCardScanner extends StatefulWidget {
  final List<CameraDescription> cameras;
  const IDCardScanner({
    super.key,
    required this.cameras,
  });

  @override
  State<IDCardScanner> createState() => _IDCardScannerState();
}

class _IDCardScannerState extends State<IDCardScanner> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCardDetected = false;
  bool _isImageClear = false;
  bool _autoCapture = true;
  String _message = 'Position card within frame';
  int _countdown = 0;
  Timer? _detectionTimer;
  Timer? _countdownTimer;
  Uint8List? _capturedImage;
  File? _capturedImageFile;
  bool _isProcessing = false;
  int _stableFrameCount = 0;
  static const int _requiredStableFrames = 3;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isEmpty) {
      setState(() => _message = 'No camera found');
      return;
    }

    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _controller!.initialize();
      await _controller!.setFlashMode(FlashMode.off);
      setState(() => _isInitialized = true);
      _startDetection();
    } catch (e) {
      setState(() => _message = 'Camera error: ${e.toString()}');
    }
  }

  void _startDetection() {
    // Cancel existing timer if any
    _detectionTimer?.cancel();

    _detectionTimer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        // Double check we should still be detecting
        if (_capturedImage != null || !mounted) {
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
        _isProcessing ||
        _capturedImage != null) {
      return;
    }

    _isProcessing = true;

    try {
      final image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null) {
        _isProcessing = false;
        return;
      }

      // Define frame area (ID card aspect ratio 1.586:1) - smaller frame
      final screenWidth = decodedImage.width * 0.75;
      final frameWidth = screenWidth.toInt();
      final frameHeight = (screenWidth / 1.586).toInt();
      final frameX = ((decodedImage.width - frameWidth) / 2).toInt();
      final frameY = ((decodedImage.height - frameHeight) / 2).toInt();

      // Crop to frame area
      final croppedImage = img.copyCrop(
        decodedImage,
        x: frameX,
        y: frameY,
        width: frameWidth,
        height: frameHeight,
      );

      // Enhanced card detection
      final cardPresent = _checkCardPresence(croppedImage);
      final imageClear = _checkImageClarity(croppedImage);

      // Check if card fills the frame properly
      final cardFillsFrame = _checkCardFillsFrame(croppedImage);

      final bothConditionsMet = cardPresent && imageClear && cardFillsFrame;

      if (bothConditionsMet) {
        _stableFrameCount++;
      } else {
        _stableFrameCount = 0;
      }

      if (mounted) {
        setState(() {
          _isCardDetected = cardPresent && cardFillsFrame;
          _isImageClear = imageClear;

          if (_stableFrameCount >= _requiredStableFrames) {
            _message = 'Card detected - Hold steady';
            if (_autoCapture && _countdown == 0 && _capturedImage == null) {
              _startCountdown();
            }
          } else if (cardPresent && !imageClear) {
            _message = 'Image blurry - Hold steady';
            _resetCountdown();
          } else if (cardPresent && !cardFillsFrame) {
            _message = 'Move card inside the frame completely';
            _resetCountdown();
          } else {
            _message = 'Position card within frame';
            _resetCountdown();
          }
        });
      }
    } catch (e) {
      print('Detection error: $e');
    }

    _isProcessing = false;
  }

  bool _checkCardPresence(img.Image image) {
    int edgeCount = 0;
    int strongEdgeCount = 0;
    const threshold = 45; // Balanced threshold
    const strongThreshold = 90;

    // Enhanced edge detection with both horizontal and vertical edges
    for (int y = 5; y < image.height - 5; y += 6) {
      for (int x = 5; x < image.width - 5; x += 6) {
        final pixel = image.getPixel(x, y);
        final pixelRight = image.getPixel(x + 5, y);
        final pixelBottom = image.getPixel(x, y + 5);

        final lumCenter = _getLuminance(pixel);
        final lumRight = _getLuminance(pixelRight);
        final lumBottom = _getLuminance(pixelBottom);

        final edgeHorizontal = (lumCenter - lumRight).abs();
        final edgeVertical = (lumCenter - lumBottom).abs();

        final maxEdge =
            edgeHorizontal > edgeVertical ? edgeHorizontal : edgeVertical;

        if (maxEdge > threshold) {
          edgeCount++;
          if (maxEdge > strongThreshold) {
            strongEdgeCount++;
          }
        }
      }
    }

    // Card should have significant strong edges
    return edgeCount > 180 && strongEdgeCount > 40;
  }

  bool _checkCardFillsFrame(img.Image image) {
    // Strategy: Check that there's NO card edge in the outer margin area
    // This ensures the card is fully inside the frame, not outside it

    const marginSize = 30; // Check outer 30px margin
    int edgesInMargin = 0;
    int totalMarginSamples = 0;

    // Check top margin (should be background, not card)
    for (int x = marginSize; x < image.width - marginSize; x += 8) {
      for (int y = 5; y < marginSize; y += 5) {
        if (y + 5 < marginSize) {
          final pixel1 = image.getPixel(x, y);
          final pixel2 = image.getPixel(x, y + 5);
          final lum1 = _getLuminance(pixel1);
          final lum2 = _getLuminance(pixel2);

          if ((lum1 - lum2).abs() > 50) {
            edgesInMargin++;
          }
          totalMarginSamples++;
        }
      }
    }

    // Check bottom margin
    for (int x = marginSize; x < image.width - marginSize; x += 8) {
      for (int y = image.height - marginSize; y < image.height - 5; y += 5) {
        if (y + 5 < image.height - 5) {
          final pixel1 = image.getPixel(x, y);
          final pixel2 = image.getPixel(x, y + 5);
          final lum1 = _getLuminance(pixel1);
          final lum2 = _getLuminance(pixel2);

          if ((lum1 - lum2).abs() > 50) {
            edgesInMargin++;
          }
          totalMarginSamples++;
        }
      }
    }

    // Check left margin
    for (int y = marginSize; y < image.height - marginSize; y += 8) {
      for (int x = 5; x < marginSize; x += 5) {
        if (x + 5 < marginSize) {
          final pixel1 = image.getPixel(x, y);
          final pixel2 = image.getPixel(x + 5, y);
          final lum1 = _getLuminance(pixel1);
          final lum2 = _getLuminance(pixel2);

          if ((lum1 - lum2).abs() > 50) {
            edgesInMargin++;
          }
          totalMarginSamples++;
        }
      }
    }

    // Check right margin
    for (int y = marginSize; y < image.height - marginSize; y += 8) {
      for (int x = image.width - marginSize; x < image.width - 5; x += 5) {
        if (x + 5 < image.width - 5) {
          final pixel1 = image.getPixel(x, y);
          final pixel2 = image.getPixel(x + 5, y);
          final lum1 = _getLuminance(pixel1);
          final lum2 = _getLuminance(pixel2);

          if ((lum1 - lum2).abs() > 50) {
            edgesInMargin++;
          }
          totalMarginSamples++;
        }
      }
    }

    if (totalMarginSamples == 0) return false;

    final edgeRatioInMargin = edgesInMargin / totalMarginSamples;

    // Now check that there ARE edges in the inner area (the actual card)
    int innerEdges = 0;
    int innerSamples = 0;

    // Check inner area for card presence
    for (int y = marginSize + 10; y < image.height - marginSize - 10; y += 10) {
      for (int x = marginSize + 10;
          x < image.width - marginSize - 10;
          x += 10) {
        if (x + 5 < image.width - marginSize - 10 &&
            y + 5 < image.height - marginSize - 10) {
          final pixel1 = image.getPixel(x, y);
          final pixel2 = image.getPixel(x + 5, y);
          final pixel3 = image.getPixel(x, y + 5);

          final lum1 = _getLuminance(pixel1);
          final lum2 = _getLuminance(pixel2);
          final lum3 = _getLuminance(pixel3);

          if ((lum1 - lum2).abs() > 40 || (lum1 - lum3).abs() > 40) {
            innerEdges++;
          }
          innerSamples++;
        }
      }
    }

    final innerEdgeRatio = innerSamples > 0 ? innerEdges / innerSamples : 0;

    // Card is properly inside frame if:
    // 1. Very few edges in the margin area (card not extending outside)
    // 2. Good amount of edges in inner area (card is present)
    return edgeRatioInMargin < 0.10 && innerEdgeRatio > 0.10;
  }

  bool _checkImageClarity(img.Image image) {
    double laplacianSum = 0;
    int sampleCount = 0;

    // Enhanced Laplacian variance for blur detection
    // Sample more densely for better accuracy
    for (int y = 2; y < image.height - 2; y += 3) {
      for (int x = 2; x < image.width - 2; x += 3) {
        final center = _getLuminance(image.getPixel(x, y));
        final top = _getLuminance(image.getPixel(x, y - 2));
        final bottom = _getLuminance(image.getPixel(x, y + 2));
        final left = _getLuminance(image.getPixel(x - 2, y));
        final right = _getLuminance(image.getPixel(x + 2, y));

        final laplacian = (4 * center - top - bottom - left - right).abs();
        laplacianSum += laplacian;
        sampleCount++;
      }
    }

    final variance = laplacianSum / sampleCount;
    // Balanced threshold
    return variance > 18;
  }

  double _getLuminance(img.Pixel pixel) {
    return 0.299 * pixel.r + 0.587 * pixel.g + 0.114 * pixel.b;
  }

  void _startCountdown() {
    if (_countdownTimer != null && _countdownTimer!.isActive) return;

    // int count = 1;
    // setState(() => _countdown = count);

    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // count--;
        // setState(() => _countdown = count);

        // if (count == 0) {
        timer.cancel();
        _captureImage();
        // }
      },
    );
  }

  void _resetCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    if (_countdown != 0) {
      setState(() => _countdown = 0);
    }
  }

  Future<void> _captureImage() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isProcessing ||
        _capturedImage != null) {
      return;
    }

    if (_stableFrameCount < _requiredStableFrames) {
      setState(() => _message = 'Error: Card not stable in frame');
      _resetCountdown();
      return;
    }

    // Stop detection immediately to prevent double capture
    _detectionTimer?.cancel();
    _resetCountdown();

    setState(() => _isProcessing = true);

    try {
      final image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null) {
        setState(() => _isProcessing = false);
        _startDetection(); // Restart detection if failed
        return;
      }

      // Crop to frame area (ID card ratio) - smaller frame
      final screenWidth = decodedImage.width * 0.75;
      final frameWidth = screenWidth.toInt();
      final frameHeight = (screenWidth / 1.586).toInt();
      final frameX = ((decodedImage.width - frameWidth) / 2).toInt();
      final frameY = ((decodedImage.height - frameHeight) / 2).toInt();

      final croppedImage = img.copyCrop(
        decodedImage,
        x: frameX,
        y: frameY,
        width: frameWidth,
        height: frameHeight,
      );

      final jpegBytes =
          Uint8List.fromList(img.encodeJpg(croppedImage, quality: 95));

      // Save to file
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          '${directory.path}/id_card_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(jpegBytes);

      setState(() {
        _capturedImage = jpegBytes;
        _capturedImageFile = imageFile;
        _message = 'Image captured successfully!';
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _message = 'Capture error: ${e.toString()}';
        _isProcessing = false;
      });
      _startDetection(); // Restart detection if failed
    }
  }

  Future<File?> getCapturedImageFile() async {
    return _capturedImageFile;
  }

  void _retakePhoto() {
    // Clean up old file if exists
    if (_capturedImageFile != null && _capturedImageFile!.existsSync()) {
      try {
        _capturedImageFile!.deleteSync();
      } catch (e) {
        print('Error deleting old file: $e');
      }
    }

    setState(() {
      _capturedImage = null;
      _capturedImageFile = null;
      _message = 'Position card within frame';
      _countdown = 0;
      _stableFrameCount = 0;
      _isProcessing = false;
    });

    // Small delay before restarting to ensure camera is ready
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _startDetection();
      }
    });
  }

  @override
  void dispose() {
    _detectionTimer?.cancel();
    _countdownTimer?.cancel();
    _controller?.dispose();

    // Clean up temporary file if exists
    if (_capturedImageFile != null && _capturedImageFile!.existsSync()) {
      try {
        _capturedImageFile!.deleteSync();
      } catch (e) {
        print('Error deleting file on dispose: $e');
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_capturedImage != null) {
      return _buildCaptureResult();
    }

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
    final cameraRatio = _controller!.value.aspectRatio;

    return Stack(
      children: [
        // Camera Preview - Fill screen while maintaining aspect ratio
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: size.width,
              height: size.width * cameraRatio,
              child: CameraPreview(_controller!),
            ),
          ),
        ),

        // Dark overlay outside frame
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
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
                  width: size.width * 0.75, // Smaller frame
                  height: (size.width * 0.75) / 1.586,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Header
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'ID Card Scanner',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Auto',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Switch(
                          value: _autoCapture,
                          onChanged: (value) {
                            setState(() {
                              _autoCapture = value;
                              _resetCountdown();
                            });
                          },
                          activeColor: Colors.blue,
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
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                if (_countdown > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '$_countdown',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Card Frame Overlay
        Center(
          child: _buildFrameOverlay(),
        ),

        // Status Indicators
        Positioned(
          bottom: _autoCapture ? 16 : 96,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusIndicator('Card Detected', _isCardDetected),
                _buildStatusIndicator('Image Clear', _isImageClear),
              ],
            ),
          ),
        ),

        // Manual Capture Button
        if (!_autoCapture)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: (_isCardDetected &&
                        _isImageClear &&
                        _stableFrameCount >= _requiredStableFrames)
                    ? _captureImage
                    : null,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: (_isCardDetected &&
                            _isImageClear &&
                            _stableFrameCount >= _requiredStableFrames)
                        ? Colors.white
                        : Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: (_isCardDetected &&
                                  _isImageClear &&
                                  _stableFrameCount >= _requiredStableFrames)
                              ? Colors.blue
                              : Colors.grey.shade500,
                          width: 4,
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

  Widget _buildFrameOverlay() {
    // ID card aspect ratio is 1.586:1 (85.6mm x 54mm - credit card size)
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.75; // Smaller frame
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
            color: (isReady ? Colors.green : Colors.white).withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Corner markers
          _buildCorner(Alignment.topLeft, true, true, isReady),
          _buildCorner(Alignment.topRight, true, false, isReady),
          _buildCorner(Alignment.bottomLeft, false, true, isReady),
          _buildCorner(Alignment.bottomRight, false, false, isReady),

          // Center text
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Align card here',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white,
                    width: 5,
                  )
                : BorderSide.none,
            bottom: !top
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white,
                    width: 5,
                  )
                : BorderSide.none,
            left: left
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white,
                    width: 5,
                  )
                : BorderSide.none,
            right: !left
                ? BorderSide(
                    color: isReady ? Colors.green : Colors.white,
                    width: 5,
                  )
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.grey,
            fontSize: 12,
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
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 32),
                        SizedBox(width: 8),
                        Text(
                          'Capture Successful!',
                          style: TextStyle(
                            fontSize: 24,
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
                          child: ElevatedButton(
                            onPressed: _retakePhoto,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade600,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Retake Photo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              // Get the file
                              // final file = await getCapturedImageFile();
                              Navigator.pop(context, _capturedImageFile);
                              // if (file != null) {
                              //   // Use the file - upload to server, save, etc.
                              //   print('Image file path: ${file.path}');
                              //
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content:
                              //           Text('Image saved at: ${file.path}'),
                              //       backgroundColor: Colors.green,
                              //     ),
                              //   );
                              //
                              //   // Example: You can now upload this file to your server
                              //   // await uploadToServer(file);
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Confirm & Upload',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
