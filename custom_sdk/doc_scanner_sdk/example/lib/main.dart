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
        _showMessage('Document scanned successfully!', isError: false);
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
        _showMessage('Images captured successfully!', isError: false);
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
        _showMessage('PDF created successfully!', isError: false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner SDK'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Info Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade700),
                    const SizedBox(height: 8),
                    const Text(
                      'Scanner Mode: BASE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Images appear without automatic enhancement',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _scanDocuments,
              icon: const Icon(Icons.document_scanner),
              label: const Text('Scan Documents (Images + PDF)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _scanAsImages,
              icon: const Icon(Icons.image),
              label: const Text('Scan as Images Only'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _scanAsPdf,
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Scan as PDF Only'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
            
            const SizedBox(height: 24),
            
            if (_isLoading) 
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              ),
              
            if (_result != null) ...[
              const Divider(),
              const Text(
                'Result:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
            
            if (_images.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Scanned Images (${_images.length}):',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  final file = File(_images[index].replaceFirst('file://', ''));
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: file.existsSync()
                        ? Image.file(file, fit: BoxFit.cover)
                        : Center(child: Text('Page ${index + 1}')),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
