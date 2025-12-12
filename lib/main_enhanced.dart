import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doc_scanner_sdk/doc_scanner_sdk.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scanner = DocScannerSdk();
  bool _isLoading = false;

  Future<void> _scanDocuments() async {
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocuments(page: 5);
      if (result != null && result['images'] != null) {
        List<String> images = List<String>.from(result['images']);
        if (images.isNotEmpty && mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageProcessingScreen(
                imagePaths: images,
                pdfUri: result['pdfUri'],
              ),
            ),
          );
        }
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    }
    setState(() => _isLoading = false);
  }

  Future<void> _scanAsImages() async {
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocumentsAsImages(page: 5);
      if (result != null) {
        List<String> images = List<String>.from(result);
        if (images.isNotEmpty && mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageProcessingScreen(imagePaths: images),
            ),
          );
        }
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    }
    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner SDK'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.document_scanner, size: 100, color: Colors.blue.shade700),
                const SizedBox(height: 32),
                const Text(
                  'Document Scanner',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Scan documents with manual enhancement control',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 48),
                if (_isLoading)
                  const CircularProgressIndicator()
                else ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _scanDocuments,
                      icon: const Icon(Icons.document_scanner, size: 24),
                      label: const Text('Scan Documents (Images + PDF)'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(18),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _scanAsImages,
                      icon: const Icon(Icons.image, size: 24),
                      label: const Text('Scan as Images Only'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(18),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Image Processing Screen with Enhancement Options
class ImageProcessingScreen extends StatefulWidget {
  final List<String> imagePaths;
  final String? pdfUri;

  const ImageProcessingScreen({
    Key? key,
    required this.imagePaths,
    this.pdfUri,
  }) : super(key: key);

  @override
  State<ImageProcessingScreen> createState() => _ImageProcessingScreenState();
}

class _ImageProcessingScreenState extends State<ImageProcessingScreen> {
  int _currentIndex = 0;
  Map<int, Uint8List?> _processedImages = {};
  Map<int, ImageFilter> _appliedFilters = {};
  Map<int, double> _rotations = {}; // Store rotation in degrees
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    // Initialize with original images (no processing)
    for (int i = 0; i < widget.imagePaths.length; i++) {
      _appliedFilters[i] = ImageFilter.none;
      _rotations[i] = 0;
    }
  }

  File _getImageFile(int index) {
    return File(widget.imagePaths[index].replaceFirst('file://', ''));
  }

  Future<void> _applyEnhancement() async {
    setState(() => _isProcessing = true);
    try {
      final file = _getImageFile(_currentIndex);
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image != null) {
        // Apply contrast and brightness enhancement
        final enhanced = img.adjustColor(
          image,
          contrast: 1.3,
          brightness: 1.1,
        );
        
        // Sharpen the image
        final sharpened = img.convolution(
          enhanced,
          filter: [0, -1, 0, -1, 5, -1, 0, -1, 0],
        );

        setState(() {
          _processedImages[_currentIndex] = Uint8List.fromList(img.encodeJpg(sharpened));
          _appliedFilters[_currentIndex] = ImageFilter.enhanced;
        });
        _showMessage('Enhancement applied');
      }
    } catch (e) {
      _showMessage('Enhancement failed: $e');
    }
    setState(() => _isProcessing = false);
  }

  Future<void> _applyFilter(ImageFilter filter) async {
    setState(() => _isProcessing = true);
    try {
      final file = _getImageFile(_currentIndex);
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image != null) {
        img.Image processed = image;

        switch (filter) {
          case ImageFilter.blackAndWhite:
            processed = img.grayscale(image);
            break;
          case ImageFilter.sepia:
            processed = img.sepia(image);
            break;
          case ImageFilter.vivid:
            processed = img.adjustColor(image, saturation: 1.5);
            break;
          case ImageFilter.cool:
            // Add blue tint by adjusting color balance
            processed = img.adjustColor(image, saturation: 1.1);
            for (var pixel in processed) {
              pixel.b = (pixel.b * 1.3).clamp(0, 255).toInt();
            }
            break;
          case ImageFilter.warm:
            // Add warm/red tint by adjusting color balance
            processed = img.adjustColor(image, saturation: 1.1);
            for (var pixel in processed) {
              pixel.r = (pixel.r * 1.3).clamp(0, 255).toInt();
              pixel.g = (pixel.g * 1.1).clamp(0, 255).toInt();
            }
            break;
          case ImageFilter.none:
            _processedImages.remove(_currentIndex);
            _appliedFilters[_currentIndex] = ImageFilter.none;
            setState(() => _isProcessing = false);
            _showMessage('Filter removed');
            return;
          default:
            break;
        }

        setState(() {
          _processedImages[_currentIndex] = Uint8List.fromList(img.encodeJpg(processed));
          _appliedFilters[_currentIndex] = filter;
        });
        _showMessage('${filter.name} filter applied');
      }
    } catch (e) {
      _showMessage('Filter failed: $e');
    }
    setState(() => _isProcessing = false);
  }

  void _rotateImage() {
    setState(() {
      _rotations[_currentIndex] = (_rotations[_currentIndex]! + 90) % 360;
    });
    _showMessage('Image rotated');
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Apply Filter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ImageFilter.values.map((filter) {
                final isSelected = _appliedFilters[_currentIndex] == filter;
                return FilterChip(
                  label: Text(filter.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    Navigator.pop(context);
                    _applyFilter(filter);
                  },
                  selectedColor: Colors.blue.shade100,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildImageDisplay() {
    final hasProcessed = _processedImages.containsKey(_currentIndex);
    final rotation = _rotations[_currentIndex] ?? 0;

    return Transform.rotate(
      angle: rotation * 3.14159 / 180, // Convert degrees to radians
      child: hasProcessed
          ? Image.memory(
              _processedImages[_currentIndex]!,
              fit: BoxFit.contain,
            )
          : Image.file(
              _getImageFile(_currentIndex),
              fit: BoxFit.contain,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Document ${_currentIndex + 1}/${widget.imagePaths.length}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_appliedFilters[_currentIndex] != ImageFilter.none)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(
                label: Text(
                  _appliedFilters[_currentIndex]!.displayName,
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.blue.shade100,
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Image Display Area
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : _buildImageDisplay(),
                ),
                // Navigation arrows
                if (widget.imagePaths.length > 1) ...[
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left, size: 40),
                        color: Colors.white,
                        onPressed: _currentIndex > 0
                            ? () => setState(() => _currentIndex--)
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.chevron_right, size: 40),
                        color: Colors.white,
                        onPressed: _currentIndex < widget.imagePaths.length - 1
                            ? () => setState(() => _currentIndex++)
                            : null,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Action Buttons
          Container(
            color: Colors.grey.shade900,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.auto_fix_high,
                  label: 'Enhance',
                  onTap: _isProcessing ? null : _applyEnhancement,
                  isActive: _appliedFilters[_currentIndex] == ImageFilter.enhanced,
                ),
                _buildActionButton(
                  icon: Icons.filter,
                  label: 'Filters',
                  onTap: _isProcessing ? null : _showFilterDialog,
                ),
                _buildActionButton(
                  icon: Icons.rotate_right,
                  label: 'Rotate',
                  onTap: _isProcessing ? null : _rotateImage,
                ),
                _buildActionButton(
                  icon: Icons.check_circle,
                  label: 'Done',
                  onTap: () => Navigator.pop(context),
                  color: Colors.green,
                ),
              ],
            ),
          ),

          // Page Indicator
          if (widget.imagePaths.length > 1)
            Container(
              color: Colors.grey.shade900,
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imagePaths.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentIndex
                          ? Colors.blue
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    Color? color,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: onTap == null
                  ? Colors.grey
                  : (color ?? Colors.white),
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: onTap == null
                    ? Colors.grey
                    : (color ?? Colors.white),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ImageFilter {
  none,
  enhanced,
  blackAndWhite,
  sepia,
  vivid,
  cool,
  warm,
}

extension ImageFilterExtension on ImageFilter {
  String get displayName {
    switch (this) {
      case ImageFilter.none:
        return 'None';
      case ImageFilter.enhanced:
        return 'Enhanced';
      case ImageFilter.blackAndWhite:
        return 'B&W';
      case ImageFilter.sepia:
        return 'Sepia';
      case ImageFilter.vivid:
        return 'Vivid';
      case ImageFilter.cool:
        return 'Cool';
      case ImageFilter.warm:
        return 'Warm';
    }
  }
}
