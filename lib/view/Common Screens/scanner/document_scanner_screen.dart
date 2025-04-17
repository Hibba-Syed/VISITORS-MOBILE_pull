import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class TextExtractionScreen extends StatefulWidget {
  final String imagePath; // Path of scanned ID card

  const TextExtractionScreen({super.key, required this.imagePath});

  @override
  State<TextExtractionScreen> createState() => _TextExtractionScreenState();
}

class _TextExtractionScreenState extends State<TextExtractionScreen> {
  String? _croppedProfilePath;
  bool _isProcessing = false;

  Future<void> _cropProfileFromId() async {
    setState(() => _isProcessing = true);

    try {
      // Crop the profile picture area from ID
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: widget.imagePath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.25), // ID photo ratio
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile from ID',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
        ],
      );

      if (croppedFile != null) {
        // Save to app directory
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedPath = path.join(directory.path, fileName);
        await File(croppedFile.path).copy(savedPath);

        setState(() => _croppedProfilePath = savedPath);
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extract Profile from ID')),
      body: Column(
        children: [
          // Display scanned ID
          Expanded(
            child: Image.file(File(widget.imagePath)),
          ),
          // Crop button
          ElevatedButton(
            onPressed: _isProcessing ? null : _cropProfileFromId,
            child: _isProcessing
                ? const CircularProgressIndicator()
                : const Text('Crop Profile Picture'),
          ),
          // Show cropped result
          if (_croppedProfilePath != null)
            SizedBox(
              height: 150,
              child: Image.file(File(_croppedProfilePath!)),
            ),
        ],
      ),
    );
  }
}