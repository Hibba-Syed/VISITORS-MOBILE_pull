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

  Future<void> _scanDocuments() async {
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocuments(page: 5);
      setState(() {
        _result = result;
        if (result != null && result['images'] != null) {
          _images = List<String>.from(result['images']);
        }
      });
      print('Scan result: $result');
      
      if (result != null) {
        _showSuccessMessage('Document scanned successfully! ${_images.length} pages captured.');
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    } catch (e) {
      _showError('Error: $e');
    }
    setState(() => _isLoading = false);
  }

  Future<void> _scanAsImages() async {
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
        _showSuccessMessage('${_images.length} images captured successfully!');
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    } catch (e) {
      _showError('Error: $e');
    }
    setState(() => _isLoading = false);
  }

  Future<void> _scanAsPdf() async {
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocumentsAsPdf(page: 5);
      setState(() {
        _result = result;
        _images = [];
      });
      
      if (result != null) {
        _showSuccessMessage('PDF created successfully!');
      }
    } on PlatformException catch (e) {
      _showError(e.message ?? 'Unknown error');
    } catch (e) {
      _showError('Error: $e');
    }
    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        'Images will appear without automatic enhancement. You have full control!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Scan Buttons
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _scanDocuments,
                icon: const Icon(Icons.document_scanner, size: 24),
                label: const Text('Scan Documents (Images + PDF)'),
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
                onPressed: _isLoading ? null : _scanAsImages,
                icon: const Icon(Icons.image, size: 24),
                label: const Text('Scan as Images Only'),
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
              const SizedBox(height: 12),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _scanAsPdf,
                icon: const Icon(Icons.picture_as_pdf, size: 24),
                label: const Text('Scan as PDF Only'),
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
                                _buildInfoRow('Images', '${(_result['images'] as List?)?.length ?? 0} pages'),
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
