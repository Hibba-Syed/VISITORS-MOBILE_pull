// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
//
// import 'package:image_picker/image_picker.dart';
// import 'package:visitors/image_view_screen.dart';
//
// class EmiratesIDScanner extends StatefulWidget {
//   const EmiratesIDScanner({super.key});
//
//   @override
//   State<EmiratesIDScanner> createState() => _EmiratesIDScannerState();
// }
//
// class _EmiratesIDScannerState extends State<EmiratesIDScanner> {
//   CameraController? _cameraController;
//   late List<CameraDescription> cameras;
//   bool isAligned = false;
//   XFile? _capturedImage;
//
//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }
//
//   Future<void> initCamera() async {
//     cameras = await availableCameras();
//     _cameraController = CameraController(
//       cameras[0], // Back camera
//       ResolutionPreset.medium,
//     );
//     await _cameraController!.initialize();
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Emirates ID Scanner')),
//       body: Stack(
//         children: [
//           if (_cameraController?.value.isInitialized ?? false)
//             CameraPreview(
//               _cameraController!,
//             ),
//           Center(
//             child: FrameOverlay(isAligned: isAligned),
//           ),
//         ],
//       ),
//       floatingActionButton: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             onPressed: captureAndAnalyze,
//             icon: const Icon(
//               Icons.camera_alt,
//             ),
//           ),
//           if (_capturedImage?.path.isNotEmpty ?? false)
//             IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return ImageViewScreen(path: _capturedImage!.path);
//                 }));
//               },
//               icon: const Icon(
//                 Icons.visibility,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> captureAndAnalyze() async {
//     try {
//       final picture = await _cameraController?.takePicture();
//       _capturedImage = picture;
//       setState(() {});
//       print('pic::: ${picture?.path}');
//       if (picture != null) {
//         analyzeImage(picture.path);
//       }
//     } catch (e) {
//       debugPrint('Error capturing image: $e');
//     }
//   }
//
//   Future<void> analyzeImage(String path) async {
//     final InputImage inputImage = InputImage.fromFilePath(path);
//
//     final objectDetector = ObjectDetector(
//       options: ObjectDetectorOptions(
//         mode: DetectionMode.stream,
//         classifyObjects: false,
//         multipleObjects: false,
//       ),
//     );
//
//     try {
//       final List<DetectedObject> objects =
//           await objectDetector.processImage(inputImage);
//
//       bool isAligned = false;
//
//       print('objects:: $objects');
//       for (DetectedObject object in objects) {
//         // Check if the detected object matches the ID card's approximate size and position
//         final boundingBox = object.boundingBox;
//         print('bounding box:: ${boundingBox.width}, ${boundingBox.height}');
//
//         // Define acceptable size and alignment thresholds
//         const double cardWidth = 539;
//         const double cardHeight = 340;
//         const double tolerance = 50; // Adjust tolerance as needed
//
//         if ((boundingBox.width - cardWidth).abs() <= tolerance &&
//             (boundingBox.height - cardHeight).abs() <= tolerance) {
//           isAligned = true;
//         }
//       }
//
//       setState(() {
//         this.isAligned = isAligned;
//       });
//     } catch (e) {
//       debugPrint('Error in edge detection: $e');
//     } finally {
//       objectDetector.close();
//     }
//   }
// }
//
// class FrameOverlay extends StatelessWidget {
//   final bool isAligned;
//
//   const FrameOverlay({super.key, required this.isAligned});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 539,
//       height: 340,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: isAligned ? Colors.green : Colors.red,
//           width: 4,
//         ),
//       ),
//     );
//   }
// }
