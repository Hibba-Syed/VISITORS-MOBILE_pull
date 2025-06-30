import 'dart:io';

class PassportModel {
  final File? personImage;
  final String? name;
  final String? passportNumber;
  final String? issueDate;
  final String? expiryDate;
  final String? nationality;

  PassportModel({
    required this.personImage,
    required this.name,
    required this.passportNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.nationality,
  });
}
