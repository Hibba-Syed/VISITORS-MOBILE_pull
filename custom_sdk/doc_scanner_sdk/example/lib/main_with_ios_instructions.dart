import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doc_scanner_sdk/doc_scanner_sdk.dart';

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
    // Show instructions for iOS users
    if (Platform.isIOS) {
      final proceed = await _showIOSInstructions();
      if (proceed != true) return;
    }

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

  Future<bool?> _showIOSInstructions() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 8),
            Text('Important Tip'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To scan without filters:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildInstructionStep(
              '1',
              'After camera opens',
            ),
            _buildInstructionStep(
              '2',
              'Tap the filter button at the bottom',
            ),
            _buildInstructionStep(
              '3',
              'It will show "Auto" by default',
            ),
            _buildInstructionStep(
              '4',
              'Select "Photo" from the options',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '"Photo" mode gives you the original image without any filters!',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Got it! Open Scanner'),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scanAsImages() async {
    if (Platform.isIOS) {
      final proceed = await _showIOSInstructions();
      if (proceed != true) return;
    }

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
                Text(
                  Platform.isIOS
                      ? 'Scan documents without filters\nTip: Select "Photo" mode in scanner'
                      : 'Scan documents without automatic enhancement',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
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

// Image Processing Screen (same as before)
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

  File _getImageFile(int index) {
    return File(widget.imagePaths[index].replaceFirst('file://', ''));
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
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Image.file(
                    _getImageFile(_currentIndex),
                    fit: BoxFit.contain,
                  ),
                ),
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
          Container(
            color: Colors.grey.shade900,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check_circle, color: Colors.green),
                  label: const Text('Done', style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
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
}
