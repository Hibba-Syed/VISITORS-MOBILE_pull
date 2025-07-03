import 'dart:io';

class OcrModel {
  final File? personImage;
  final String? recognizedTExt;
  OcrModel({
    required this.personImage,
    required this.recognizedTExt,
  });
}
