import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:intl/intl.dart';
import 'package:mrz_parser/mrz_parser.dart';

import '../../helper/mrz_helper.dart';
import '../../model/driving_license_model.dart';
import '../../model/emirates_id_model.dart';
import '../../model/ocr_model.dart';
import '../../model/passport_model.dart';
import '../../utils/app_utils.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

import '../../utils/date_time.dart';

class ScannerService {
  Future<EmiratesIdModel?> scanEmiratesIdAndPerformOcr() async {
    EmiratesIdModel? emiratesIdData;
    OcrModel? ocrData = await _scanDocumentAndPerformOCR();
    String? recognizedText;
    if (ocrData != null) {
      recognizedText = ocrData.recognizedTExt;
      // print(' EmiratesId Text: $recognizedText');

      final scannedText = recognizedText?.toLowerCase() ?? '';
      if (!scannedText.toLowerCase().contains('id number')) {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'scannedDocumentNotValidPleaseTryAgainUsingAValidDocument'));
        return null;
      }
      if (recognizedText?.isNotEmpty ?? false) {
        final Map<String, String> parsedText =
            _parseEmiratesIdExtractedText(recognizedText!);

        emiratesIdData = EmiratesIdModel(
          personImage: ocrData.personImage,
          name: parsedText['Name'] ?? '',
          idNumber: parsedText['ID Number'] ?? '',
          issueDate: parsedText['Issuing Date'] ?? '',
          expiryDate: parsedText['Expiry Date'] ?? '',
          nationality: parsedText['Nationality'] ?? parsedText['nationality'],
        );
        return emiratesIdData;
      }
    }
    return null;
  }

  Future<DrivingLicenseModel?> scanDrivingLicenseAndPerformOcr() async {
    OcrModel? ocrData = await _scanDocumentAndPerformOCR();
    String? recognizedText;
    if (ocrData != null) {
      recognizedText = ocrData.recognizedTExt;

      final scannedText = recognizedText?.toLowerCase() ?? '';
      if (!scannedText.contains('driving')) {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'scannedDocumentNotValidPleaseTryAgainUsingAValidDocument'));
        return null;
      }

      if (recognizedText?.isNotEmpty ?? false) {
        DrivingLicenseModel? drivingLicenseData =
            _parseDrivingLicenseExtractedText(
                recognizedText!, ocrData.personImage);
        return drivingLicenseData;
      }
    }
    return null;
  }

  Future<PassportModel?> scanMrzForPassportAndParse(
      BuildContext context) async {
    final DocumentScannerOptions documentOptions = DocumentScannerOptions(
      documentFormat: DocumentFormat.jpeg,
      mode: ScannerMode.full,
      pageLimit: 1,
      isGalleryImport: false,
    );
    final documentScanner = DocumentScanner(options: documentOptions);
    DocumentScanningResult result = await documentScanner.scanDocument();
    File? scannedImageFile;
    final List<String> images = result.images;
    if (images.isNotEmpty && images.first.isNotEmpty) {
      scannedImageFile = File(images.first);
      final path = images.first;
      final inputImage = InputImage.fromFilePath(path);

      final textRecognizer = TextRecognizer();
      final visionText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();
      FaceDetector faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          performanceMode: FaceDetectorMode.accurate,
          minFaceSize: 1,
        ),
      );
      final List<Face> faces = await faceDetector.processImage(inputImage);
      final File? extractedPersonImage =
          _extractPersonImage(scannedImageFile, faces);
      faceDetector.close();

      final rawLines = visionText.text
          .replaceAll(' ', '')
          .split('\n')
          .where((line) => MRZHelper.testTextLine(line).isNotEmpty)
          .map((line) => MRZHelper.testTextLine(line))
          .toList();

      final mrzLines = MRZHelper.getFinalListToParse(rawLines);

      if (mrzLines != null) {
        final result = MRZParser.parse(mrzLines);
        PassportModel passportData = PassportModel(
          personImage: extractedPersonImage,
          name: result.givenNames,
          passportNumber: result.documentNumber,
          issueDate: result.expiryDate.toString(),
          expiryDate: result.expiryDate.toString(),
          nationality:
              AppUtils.getNationalityName(result.nationalityCountryCode),
        );
        //  print('document type:: ${result.documentType}');
        if (result.documentType.toLowerCase() != 'p') {
          Fluttertoast.showToast(
              msg: AppUtils.languageTranslate(
                  'scannedDocumentNotValidPleaseTryAgainUsingAValidDocument'));
          return null;
        }
        return passportData;
      } else {
        debugPrint('No valid MRZ detected.');
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'scannedDocumentNotValidPleaseTryAgainUsingAValidDocument'));
      }
    }
    return null;
  }

  Future<PassportModel?> scanPassportAndPerformOcr() async {
    OcrModel? ocrData = await _scanDocumentAndPerformOCR();
    String? recognizedText;
    if (ocrData != null) {
      recognizedText = ocrData.recognizedTExt;
      if (recognizedText?.isNotEmpty ?? false) {
        PassportModel? passportData =
            _parsePassportExtractedText(recognizedText!, ocrData.personImage);

        return passportData;
      }
    }
    return null;
  }

  Future<OcrModel?> _scanDocumentAndPerformOCR() async {
    try {
      DocumentScannerOptions documentOptions = DocumentScannerOptions(
        documentFormat: DocumentFormat.jpeg, // set output document format
        mode: ScannerMode.base, // to control what features are enabled
        pageLimit: 1, // setting a limit to the number of pages scanned
        isGalleryImport: false, // importing from the photo gallery
      );
      final documentScanner = DocumentScanner(options: documentOptions);
      DocumentScanningResult result = await documentScanner.scanDocument();
      File? scannedImageFile;
      final List<String> images = result.images;
      if (images.isNotEmpty && images.first.isNotEmpty) {
        scannedImageFile = File(images.first);

        return await _performOCR(scannedImageFile);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<OcrModel?> _performOCR(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    TextRecognizer textDetector =
        TextRecognizer(script: TextRecognitionScript.latin);
    FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        minFaceSize: 1,
      ),
    );

    final RecognizedText recognizedText =
        await textDetector.processImage(inputImage);
    String text = recognizedText.text;

    final List<Face> faces = await faceDetector.processImage(inputImage);

    final File? extractedPersonImage = _extractPersonImage(imageFile, faces);
    textDetector.close();
    faceDetector.close();
    if (text.isNotEmpty && extractedPersonImage != null) {
      return OcrModel(personImage: extractedPersonImage, recognizedTExt: text);
    } else {
      return null;
    }
  }

  File? _extractPersonImage(File originalImage, List<Face> faces) {
    if (faces.isNotEmpty) {
      File? image;
      for (int i = 0; i < faces.length; i++) {
        final face = faces[i];
        final boundingBox = face.boundingBox;
        image = _cropImage(originalImage, boundingBox, index: i);
      }
      return image;
    }
    return null; // Return null if no image is extracted
  }

  File? _cropImage(
    File originalImage,
    Rect boundingBox, {
    required int index,
  }) {
    // Load the original image
    final img.Image originalImg =
        img.decodeImage(originalImage.readAsBytesSync())!;

    // Calculate the cropping dimensions
    final int left = boundingBox.left.toInt() - 130;
    final int top = boundingBox.top.toInt() - 130;
    final int width = ((boundingBox.right - boundingBox.left).toInt()) + 270;
    final int height = ((boundingBox.bottom - boundingBox.top).toInt()) + 270;
    // Crop the image
    final img.Image croppedImg = img.copyCrop(originalImg,
        x: left, y: top, width: width, height: height);

    // Save the cropped image to a new file
    final String fileName =
        '${path.basenameWithoutExtension(originalImage.path)}_cropped_$index.jpg';
    final String dir = path.dirname(originalImage.path);
    final File croppedFile = File('$dir/$fileName')
      ..writeAsBytesSync(img.encodeJpg(croppedImg));

    return croppedFile; // Return the cropped image file
  }

  Map<String, String> _parseEmiratesIdExtractedText(String text) {
    Map<String, String> parsedData = {};
    List<String> lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      String lineLower = line.toLowerCase();

      // ID Number
      if (lineLower.contains('رقم الهوية') || lineLower.contains('id number')) {
        parsedData['ID Number'] = _extractValue(line, lines, i);
      }
      // Name (special case)
      else if (lineLower.contains('الاسم') || lineLower.contains('name')) {
        if (line.contains(':')) {
          parsedData['Name'] = line.split(':').last.trim();
        }
      }
      // Nationality
      else if (lineLower.contains('الجنسية') ||
          lineLower.contains('nationality')) {
        parsedData['Nationality'] = _extractValue(line, lines, i);
      }
      // Issuing Date (ONLY next line)
      else if (lineLower.contains('تاريخ الاصدار/') ||
          lineLower.contains('issuing date')) {
        if (i + 1 < lines.length) {
          parsedData['Issuing Date'] = lines[i + 1].trim();
        }
      }
      // Expiry Date (ONLY next line)
      else if (lineLower.contains('تاريخ الانتهاء/') ||
          lineLower.contains('expiry date')) {
        if (i + 1 < lines.length) {
          parsedData['Expiry Date'] = lines[i + 1].trim();
        }
      }
    }
    return parsedData;
  }

  DrivingLicenseModel _parseDrivingLicenseExtractedText(
      String rawText, File? imageFile) {
    final lines = rawText
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    String? licenseNumber;
    String? name;
    String? nationality;
    String? dateOfBirth;
    String? issueDate;
    String? expiryDate;

    // final dateRegex = RegExp(r'\d{2}/\d{2}/\d{4}');
    final dateRegex = RegExp(r'(\d{2}/\d{2}/\d{4})|' // 12/05/2023
        r'(\d{2}-\d{2}-\d{4})|' // 19-01-1993
        r'(\d{4}-\d{2}-\d{2})|' // 2023-05-12
        r'([A-Za-z]+ \d{1,2}, \d{4})|' // May 12, 2023
        r'(\d{1,2} [A-Za-z]+ \d{4})|' // 12 May 2023
        r'(\d{2}\.\d{2}\.\d{4})' // 12.05.2023
        );

    String? normalizeDate(String input) {
      final formats = [
        DateFormat('dd/MM/yyyy'),
        DateFormat('yyyy-MM-dd'),
        DateFormat('dd-MM-yyyy'),
        DateFormat('MMMM d, yyyy'),
        DateFormat('dd MMM yyyy'),
        DateFormat('dd.MM.yyyy'),
        DateFormat('d MMMM yyyy'),
      ];

      for (final format in formats) {
        try {
          final date = format.parseStrict(input);
          return DateFormat('yyyy-MM-dd').format(date);
        } catch (_) {}
      }

      return null;
    }

    final licenseRegex = RegExp(r'^\d{6,}$'); // Numeric and >= 6 digits

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      // Debug: Print current line being processed
      // License number
      if (licenseNumber == null && licenseRegex.hasMatch(line)) {
        licenseNumber = licenseRegex.firstMatch(line)!.group(0);
      }

      // Name
      if (name == null && line.toLowerCase().contains('name')) {
        name =
            line.replaceFirst(RegExp(r'name', caseSensitive: false), '').trim();
        if (name.isEmpty && i + 1 < lines.length) {
          name = lines[i + 1].trim();
        }
      }

      // Nationality
      // if (nationality == null && line.toLowerCase().contains('nationality')) {
      //   nationality = line
      //       .replaceFirst(RegExp(r'nationality', caseSensitive: false), '')
      //       .trim();
      //   if (nationality.isEmpty && i + 1 < lines.length) {
      //     print('nationality$nationality');
      //     nationality = lines[i + 1].trim();
      //   }
      // }
      /////

      if (nationality == null && line.toLowerCase().contains('nationality')) {
        // Look ahead for up to 5 lines to find a likely nationality value
        for (int j = 1; j <= 5 && i + j < lines.length; j++) {
          final nextLine = lines[i + j].trim();
          // Filter: must be a country-like value (uppercase alphabets, shortish)
          if (nextLine.isNotEmpty &&
              nextLine.length <= 30 &&
              RegExp(r'^[A-Z ]+$').hasMatch(nextLine)) {
            nationality = nextLine;
            break;
          }
        }
      }

      final matches = dateRegex.allMatches(line);
      for (final match in matches) {
        final rawDate = match.group(0);
        if (rawDate != null) {
          final normalized = normalizeDate(rawDate);
          if (normalized != null) {
            if (dateOfBirth == null) {
              dateOfBirth = normalized;
            } else if (issueDate == null) {
              issueDate = normalized;
            } else if (expiryDate == null) {
              expiryDate = normalized;
            }
          }
        }
      }

      // final matches = dateRegex.allMatches(line);
      // for (final match in matches) {
      //   final rawDate = match.group(0);
      //   if (rawDate != null) {
      //     final normalized = normalizeDate(rawDate);
      //     if (normalized != null) {
      //       if (dateOfBirth == null) {
      //         dateOfBirth = normalized;
      //       } else if (issueDate == null) {
      //         issueDate = normalized;
      //       } else if (expiryDate == null) {
      //         expiryDate = normalized;
      //       }
      //     }
      //   }
      // }
    }

    return DrivingLicenseModel(
      personImage: imageFile,
      name: name,
      licenseNumber: licenseNumber,
      issueDate: issueDate,
      expiryDate: expiryDate,
      nationality: nationality,
    );
  }

  PassportModel _parsePassportExtractedText(String rawText, File? imageFile) {
    final lines = rawText.split('\n').map((line) => line.trim()).toList();

    String? name;
    String? passportNumber;
    String? issueDate;
    String? expiryDate;
    String? nationality;

    final allDateRegex = RegExp(
      r'\b(?:\d{1,2}[\/\-. ])(?:\d{1,2}|[A-Za-z]{3,})[\/\-. ]\d{2,4}\b|'
      r'\b\d{4}[\/\-. ]\d{1,2}[\/\-. ]\d{1,2}\b|'
      r'\b\d{1,2} [A-Za-z]{3,9} \d{4}\b',
      caseSensitive: false,
    );
    final passportNoRegex = RegExp(r'^[A-Z0-9]{6,}$'); // Passport No format

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Passport Number
      if (passportNumber == null &&
          line.toLowerCase().contains('passport no')) {
        if (i + 1 < lines.length && passportNoRegex.hasMatch(lines[i + 1])) {
          passportNumber = lines[i + 1];
        }
      }

      // Name (line before "Date of Birth")
      if (name == null &&
          line.toLowerCase().contains('date of birth') &&
          i > 0) {
        name = lines[i - 1].trim();
      }

      // Nationality
      if (nationality == null && line.toLowerCase().contains('nationality')) {
        // Check same line first
        final parts = line.split(RegExp(r'nationality', caseSensitive: false));
        if (parts.length > 1 && parts[1].trim().isNotEmpty) {
          nationality = parts[1].trim();
        } else if (i + 1 < lines.length) {
          final nextLine = lines[i + 1].trim();
          // Ensure it's not an unrelated keyword like "Country Code" or name
          if (!nextLine.toLowerCase().contains('country') &&
              !nextLine.toLowerCase().contains('code') &&
              !nextLine.toLowerCase().contains('name') &&
              !allDateRegex.hasMatch(nextLine)) {
            nationality = nextLine;
          }
        }
      }

      // Dates
      final matches =
          allDateRegex.allMatches(line).map((m) => m.group(0)!.trim()).toList();
      for (final rawDate in matches) {
        final parsed = DateTimeUtil.tryParseDate(rawDate);
        if (parsed != null) {
          final formatted = DateFormat('dd/MM/yyyy').format(parsed);
          if (issueDate == null) {
            issueDate = formatted;
          } else {
            expiryDate ??= formatted;
          }
        }
      }
    }

    return PassportModel(
      personImage: imageFile,
      name: name,
      passportNumber: passportNumber,
      issueDate: issueDate,
      expiryDate: expiryDate,
      nationality: nationality,
    );
  }

  String _extractValue(String line, List<String> lines, int currentIndex) {
    if (line.contains(':')) {
      return line.split(':').last.trim();
    } else if (currentIndex + 1 < lines.length) {
      return lines[currentIndex + 1].trim();
    }
    return '';
  }
}
