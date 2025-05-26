// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart' show Face, FaceDetector, FaceDetectorOptions, InputImage, RecognizedText, TextRecognitionScript, TextRecognizer;
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img; // For image processing
// import 'package:path/path.dart' as path;
//
// class OCRScreen extends StatefulWidget {
//   const OCRScreen({super.key});
//
//   @override
//   _OCRScreenState createState() => _OCRScreenState();
// }
//
// class _OCRScreenState extends State<OCRScreen> {
//   File? _imageFile;
//   String _extractedText = '';
//   List<File?>? _personImageFiles; // To store the extracted person image
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(
//       source: ImageSource.camera,
//       maxWidth: 539,
//       maxHeight: 340
//     );
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//
//       await _performOCR(_imageFile!);
//     }
//   }
//
//   Future<void> _performOCR(File imageFile) async {
//     final inputImage = InputImage.fromFile(imageFile);
//     TextRecognizer textDetector =
//         TextRecognizer(script: TextRecognitionScript.latin);
//     FaceDetector faceDetector = FaceDetector(
//       options: FaceDetectorOptions(),
//     );
//
//     final RecognizedText recognizedText =
//         await textDetector.processImage(inputImage);
//     String text = recognizedText.text;
//
//     final List<Face> faces = await faceDetector.processImage(inputImage);
//
//     setState(() {
//       _extractedText = text;
//       _personImageFiles = _extractPersonImage(imageFile, faces);
//     });
//
//     // Dispose the detector when done
//     textDetector.close();
//   }
//
//   // Method to extract the person image from the document
//   List<File?>? _extractPersonImage(File originalImage, List<Face> faces) {
//     if (faces.isNotEmpty) {
//       print('bounding box length:: ${faces.length}');
//       // Assuming the person's image is generally on the top left
//       // final firstBlock = recognizedText.blocks.last;
//       // final boundingBox = firstBlock.boundingBox;
//
//       // Get bounding box coordinates
//       List<File?>? images = [];
//       for (int i = 0; i < faces.length; i++) {
//         final face = faces[i];
//         final boundingBox = face.boundingBox;
//         images.add(_cropImage(originalImage, boundingBox, index: i));
//       }
//       for (var element in images) {
//         print(element?.path);
//       }
//       return images;
//     }
//     return null; // Return null if no image is extracted
//   }
//
//   // Crop image based on bounding box
//   File? _cropImage(
//     File originalImage,
//     Rect boundingBox, {
//     required int index,
//   }) {
//     // Load the original image
//     final img.Image originalImg =
//         img.decodeImage(originalImage.readAsBytesSync())!;
//
//     // Calculate the cropping dimensions
//     final int left = boundingBox.left.toInt();
//     final int top = boundingBox.top.toInt();
//     final int width = (boundingBox.right - boundingBox.left).toInt();
//     final int height = (boundingBox.bottom - boundingBox.top).toInt();
//
//     print('left:: $left');
//     print('top:: $top');
//     print('width:: $width');
//     print('height:: $height');
//     // Crop the image
//     final img.Image croppedImg = img.copyCrop(originalImg,
//         x: left, y: top, width: width, height: height);
//
//     // Save the cropped image to a new file
//     final String fileName =
//         '${path.basenameWithoutExtension(originalImage.path)}_cropped_$index.jpg';
//     final String dir = path.dirname(originalImage.path);
//     final File croppedFile = File('$dir/$fileName')
//       ..writeAsBytesSync(img.encodeJpg(croppedImg));
//
//     return croppedFile; // Return the cropped image file
//   }
//
//   Map<String, String> _parseExtractedText(String text) {
//     Map<String, String> parsedData = {};
//
//     // Simple parsing logic - You can refine this based on your specific use case
//     List<String> lines = text.split('\n');
//     for (var line in lines) {
//       if (line.contains(':')) {
//         var parts = line.split(':');
//         if (parts.length >= 2) {
//           parsedData[parts[0].trim()] = parts.sublist(1).join(':').trim();
//         }
//       } else {
//         parsedData[line.trim()] = ''; // If no key-value, store the line
//       }
//     }
//     return parsedData;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Map<String, String> extractedData = _parseExtractedText(_extractedText);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OCR Example'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (_imageFile != null)
//                 Image.file(_imageFile!)
//               else
//                 Text('No image selected.'),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Capture Image'),
//               ),
//               SizedBox(height: 20),
//               if (_personImageFiles?.isNotEmpty ?? false)
//                 Column(
//                   children: [
//                     Text(
//                       'Extracted Person Images:',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Column(
//                       children: _personImageFiles?.map((element) {
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Image.file(element!),
//                             );
//                           }).toList() ??
//                           [],
//                     ),
//                   ],
//                 ),
//               SizedBox(height: 20),
//               Text(
//                 'Extracted Data:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               ...extractedData.entries.map((entry) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: Text('${entry.key}: ${entry.value}'),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
