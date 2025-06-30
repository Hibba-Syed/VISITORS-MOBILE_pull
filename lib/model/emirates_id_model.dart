import 'dart:io';

class EmiratesIdModel {
  final File? personImage;
  final String? name;
  final String? idNumber;
  final String? issueDate;
  final String? expiryDate;
  final String? nationality;

  EmiratesIdModel({
    required this.personImage,
    required this.name,
    required this.idNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.nationality,
  });
}
