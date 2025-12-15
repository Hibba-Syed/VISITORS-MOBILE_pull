import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doc_scanner_sdk/doc_scanner_sdk.dart';

void main() {
  runApp(const MaterialApp(
    home: LocalizedScannerExample(),
    debugShowCheckedModeBanner: false,
  ));
}

class LocalizedScannerExample extends StatefulWidget {
  const LocalizedScannerExample({Key? key}) : super(key: key);

  @override
  State<LocalizedScannerExample> createState() => _LocalizedScannerExampleState();
}

class _LocalizedScannerExampleState extends State<LocalizedScannerExample> {
  final _scanner = DocScannerSdk();
  String _selectedLanguage = 'English';
  List<String> _images = [];
  bool _isLoading = false;

  // Localization configurations for different languages
  DocumentScannerLocalization get _currentLocalization {
    switch (_selectedLanguage) {
      case 'Spanish':
        return const DocumentScannerLocalization(
          iosFilterButtonText: 'Filtro',
          iosSaveButtonText: 'Guardar',
          iosAddPageButtonText: 'Agregar Página',
          iosCancelButtonText: 'Cancelar',
          androidProcessingText: 'Procesando...',
          scanButtonText: 'Escanear',
          retakeButtonText: 'Volver a tomar',
          doneButtonText: 'Hecho',
        );
      case 'French':
        return const DocumentScannerLocalization(
          iosFilterButtonText: 'Filtre',
          iosSaveButtonText: 'Enregistrer',
          iosAddPageButtonText: 'Ajouter une page',
          iosCancelButtonText: 'Annuler',
          androidProcessingText: 'Traitement...',
          scanButtonText: 'Scanner',
          retakeButtonText: 'Reprendre',
          doneButtonText: 'Terminé',
        );
      case 'German':
        return const DocumentScannerLocalization(
          iosFilterButtonText: 'Filter',
          iosSaveButtonText: 'Speichern',
          iosAddPageButtonText: 'Seite hinzufügen',
          iosCancelButtonText: 'Abbrechen',
          androidProcessingText: 'Verarbeitung...',
          scanButtonText: 'Scannen',
          retakeButtonText: 'Wiederholen',
          doneButtonText: 'Fertig',
        );
      case 'Urdu':
        return const DocumentScannerLocalization(
          iosFilterButtonText: 'فلٹر',
          iosSaveButtonText: 'محفوظ کریں',
          iosAddPageButtonText: 'صفحہ شامل کریں',
          iosCancelButtonText: 'منسوخ کریں',
          androidProcessingText: 'پروسیسنگ...',
          scanButtonText: 'سکین کریں',
          retakeButtonText: 'دوبارہ لیں',
          doneButtonText: 'مکمل',
        );
      case 'Arabic':
        return const DocumentScannerLocalization(
          iosFilterButtonText: 'تصفية',
          iosSaveButtonText: 'حفظ',
          iosAddPageButtonText: 'إضافة صفحة',
          iosCancelButtonText: 'إلغاء',
          androidProcessingText: 'معالجة...',
          scanButtonText: 'مسح',
          retakeButtonText: 'إعادة التقاط',
          doneButtonText: 'تم',
        );
      case 'Chinese':
        return const DocumentScannerLocalization(
          iosFilterButtonText: '滤镜',
          iosSaveButtonText: '保存',
          iosAddPageButtonText: '添加页面',
          iosCancelButtonText: '取消',
          androidProcessingText: '处理中...',
          scanButtonText: '扫描',
          retakeButtonText: '重拍',
          doneButtonText: '完成',
        );
      default: // English
        return const DocumentScannerLocalization(
          iosFilterButtonText: 'Filter',
          iosSaveButtonText: 'Save',
          iosAddPageButtonText: 'Add Page',
          iosCancelButtonText: 'Cancel',
          androidProcessingText: 'Processing...',
          scanButtonText: 'Scan',
          retakeButtonText: 'Retake',
          doneButtonText: 'Done',
        );
    }
  }

  Future<void> _scanDocument() async {
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocument(
        localization: _currentLocalization,
      );
      
      if (result != null && result['images'] != null) {
        setState(() {
          _images = List<String>.from(result['images']);
        });
        _showMessage('Document scanned successfully!');
      }
    } on PlatformException catch (e) {
      _showMessage('Error: ${e.message}', isError: true);
    }
    setState(() => _isLoading = false);
  }

  Future<void> _scanMultipleDocuments() async {
    setState(() => _isLoading = true);
    try {
      final result = await _scanner.scanDocuments(
        page: 5,
        localization: _currentLocalization,
      );
      
      if (result != null && result['images'] != null) {
        setState(() {
          _images = List<String>.from(result['images']);
        });
        _showMessage('Documents scanned successfully!');
      }
    } on PlatformException catch (e) {
      _showMessage('Error: ${e.message}', isError: true);
    }
    setState(() => _isLoading = false);
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localized Scanner Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Language Selector
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.language, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Select Language',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedLanguage,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: [
                        'English',
                        'Spanish',
                        'French',
                        'German',
                        'Urdu',
                        'Arabic',
                        'Chinese'
                      ].map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedLanguage = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Scan Buttons
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _scanDocument,
              icon: const Icon(Icons.document_scanner, size: 24),
              label: const Text('Scan Single Document'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(18),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _scanMultipleDocuments,
              icon: const Icon(Icons.library_books, size: 24),
              label: const Text('Scan Multiple Documents'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(18),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
            
            // Info Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Localization Info',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current Language: $_selectedLanguage',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'The scanner UI will display text in the selected language.',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    if (Platform.isIOS) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'iOS Note: Some text is controlled by the system and cannot be localized.',
                        style: TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Images Grid
            if (_images.isNotEmpty) ...[
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.photo_library, color: Colors.blue),
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
                            clipBehavior: Clip.antiAlias,
                            child: file.existsSync()
                                ? Image.file(file, fit: BoxFit.cover)
                                : Container(
                                    color: Colors.grey.shade200,
                                    child: Center(child: Text('${index + 1}')),
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
    );
  }
}
