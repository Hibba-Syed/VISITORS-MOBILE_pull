import 'dart:io';

class DrivingLicenseModel {
  final File? personImage;
  final String? name;
  final String? licenseNumber;
  final String? issueDate;
  final String? expiryDate;
  final String? nationality;

  DrivingLicenseModel({
    required this.personImage,
    required this.name,
    required this.licenseNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.nationality,
  });
}
