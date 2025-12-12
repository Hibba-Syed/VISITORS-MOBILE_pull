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
  dynamic _result;
  List<String> _images = [];
  bool _isLoading = false;

  Future<void> _showIOSInstructions() async {
    if (!Platform.isIOS) return;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 8),
            Text('iOS Tip'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'For unfiltered scans:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('1. After camera opens, tap the filter button at bottom'),
            Text('2. Select "Photo" mode instead of "Auto"'),
            SizedBox(height: 8),
            Text(
              'This gives you the original image without filters.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  // Single Document Scan Methods
  Future<void> _scanSingleDocument() async {
    await _showIOSInstructions();
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocument();
      setState(() {
        _result = result;
        if (result != null && result['images'] != null) {
          _images = List<String>.from(result['images']);
        }
      });
      if (result != null) {
        _showMessage('Single document scanned successfully!', isError: false);
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    } catch (e) {
      _showError('Error: $e');
    }
    setState(() => _isLoading = false);
  }

  Future<void> _scanSingleDocumentAsImage() async {
    await _showIOSInstructions();
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocumentAsImage();
      setState(() {
        _result = result;
        if (result != null) {
          _images = List<String>.from(result);
        }
      });
      if (result != null) {
        _showMessage('Single image captured successfully!', isError: false);
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    } catch (e) {
      _showError('Error: $e');
    }
    setState(() => _isLoading = false);
  }

  // Multiple Documents Scan Methods
  Future<void> _scanMultipleDocuments() async {
    await _showIOSInstructions();
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocuments(page: 5);
      setState(() {
        _result = result;
        if (result != null && result['images'] != null) {
          _images = List<String>.from(result['images']);
        }
      });
      if (result != null) {
        _showMessage('Documents scanned successfully!', isError: false);
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    } catch (e) {
      _showError('Error: $e');
    }
    setState(() => _isLoading = false);
  }

  Future<void> _scanMultipleDocumentsAsImages() async {
    await _showIOSInstructions();
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocumentsAsImages(page: 5);
      setState(() {
        _result = result;
        if (result != null) {
          _images = List<String>.from(result);
        }
      });
      if (result != null) {
        _showMessage('Images captured successfully!', isError: false);
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    } catch (e) {
      _showError('Error: $e');
    }
    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    _showMessage(message, isError: true);
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearResults() {
    setState(() {
      _result = null;
      _images = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner SDK'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          if (_result != null)
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear Results',
              onPressed: _clearResults,
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700, size: 40),
                      const SizedBox(height: 12),
                      const Text(
                        'Scanner Mode: BASE',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Android: Images appear without automatic enhancement\niOS: Use "Photo" mode for unfiltered scans',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Single Document Section
              const Text(
                'Single Document Scan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _scanSingleDocument,
                icon: const Icon(Icons.document_scanner_outlined, size: 24),
                label: const Text('Scan Single Document'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 12),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _scanSingleDocumentAsImage,
                icon: const Icon(Icons.image_outlined, size: 24),
                label: const Text('Scan Single Image'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),

              // Multiple Documents Section
              const Text(
                'Multiple Documents Scan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _scanMultipleDocuments,
                icon: const Icon(Icons.library_books, size: 24),
                label: const Text('Scan Multiple Documents'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 12),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _scanMultipleDocumentsAsImages,
                icon: const Icon(Icons.photo_library, size: 24),
                label: const Text('Scan Multiple Images'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
              
              const SizedBox(height: 24),
              
              if (_isLoading)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Scanning document...'),
                      ],
                    ),
                  ),
                ),

              // Results Section
              if (_result != null) ...[
                const Divider(height: 32),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green.shade700),
                            const SizedBox(width: 8),
                            const Text(
                              'Scan Results',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_result is Map) ...[
                                _buildInfoRow('Images', '${(_result['images'] as List?)?.length ?? 0} page(s)'),
                                if (_result['pdfUri'] != null)
                                  _buildInfoRow('PDF', 'Generated'),
                                if (_result['pageCount'] != null)
                                  _buildInfoRow('Page Count', '${_result['pageCount']}'),
                              ] else ...[
                                Text(
                                  _result.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Image Grid
              if (_images.isNotEmpty) ...[
                const SizedBox(height: 24),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.photo_library, color: Colors.blue.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Scanned Images (${_images.length})',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            final file = File(_images[index].replaceFirst('file://', ''));
                            return Card(
                              elevation: 3,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  file.existsSync()
                                      ? Image.file(file, fit: BoxFit.cover)
                                      : Container(
                                          color: Colors.grey.shade200,
                                          child: Center(
                                            child: Text('Page ${index + 1}'),
                                          ),
                                        ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
