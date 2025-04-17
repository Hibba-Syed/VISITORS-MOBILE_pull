import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';

class IDDetailsScreen extends StatefulWidget {
  final String cardImagePath;

  const IDDetailsScreen({super.key, required this.cardImagePath});

  @override
  State<IDDetailsScreen> createState() => _IDDetailsScreenState();
}

class _IDDetailsScreenState extends State<IDDetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _idController;
  late TextEditingController _nationalityController;
  // late TextEditingController _issueDateController;
  // late TextEditingController _expiryDateController;
  String _extractedText = '';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _extractTextFromImage();
  }

  void _initializeControllers() {
    _nameController = TextEditingController();
    _idController = TextEditingController();
    _nationalityController = TextEditingController();
    // _issueDateController = TextEditingController();
    // _expiryDateController = TextEditingController();
  }

  Future<void> _extractTextFromImage() async {
    final inputImage = InputImage.fromFilePath(widget.cardImagePath);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      _extractedText = recognizedText.text;
      _parseTextFields(recognizedText.text);
    });
  }

  void _parseTextFields(String text) {
    // Example parsing logic - adjust based on document format
    final lines = text.split('\n');
    for (final line in lines) {
      if (line.contains('Name:')) {
        _nameController.text = line.replaceAll('Name:', '').trim();
      } else if (line.contains('ID Number:')) {
        _idController.text = line.replaceAll('ID Number:', '').trim();
      } else if (line.contains('Nationality:')) {
        _nationalityController.text = line.replaceAll('Nationality:', '').trim();
      }
      // else if (line.contains('Issue Date:')) {
      //   _issueDateController.text = line.replaceAll('Issue Date:', '').trim();
      // } else if (line.contains('Expiry:')) {
      //   _expiryDateController.text = line.replaceAll('Expiry:', '').trim();
      // }
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),

      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Non-editable card image
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.file(
                File(widget.cardImagePath),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // Editable text fields
            _buildTextField(_nameController, 'Full Name'),
            _buildTextField(_idController, 'ID Number'),
            _buildTextField(_nationalityController, 'Nationality'),
            // _buildDateField(_issueDateController, 'Issue Date', context),
            // _buildDateField(_expiryDateController, 'Expiry Date', context),

            // Save button
            ElevatedButton(
              onPressed: _saveData,
              child: const Text('Save Document Data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context, controller),
          ),
        ),
        readOnly: true,
      ),
    );
  }

  void _saveData() {
    // Implement save logic here
    final documentData = {
      'name': _nameController.text,
      'id': _idController.text,
      'nationality': _nationalityController,
      // 'issue_date': _issueDateController.text,
      // 'expiry_date': _expiryDateController.text,
      'card_image': widget.cardImagePath,
    };
    print('documentData$documentData');
  }
}