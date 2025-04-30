//
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
//
// import 'id_details_screen.dart';
//
// class DocumentScannerScreen extends StatefulWidget {
//
//   const DocumentScannerScreen({super.key});
//
//   @override
//   State<DocumentScannerScreen> createState() => _DocumentScannerScreenState();
// }
//
// class _DocumentScannerScreenState extends State<DocumentScannerScreen> {
//    final DocumentScanner documentScanner = DocumentScanner(
//     options: DocumentScannerOptions(
//      isGalleryImport: true,
//       mode: ScannerMode.full,
//       pageLimit: 1
//     ),
//   );
//
//    bool _isScanning = false;
//
//    Future<void> scanDocument(BuildContext context) async {
//      setState(() => _isScanning = true);
//      try {
//        final result = await documentScanner.scanDocument();
//
//        if (result.images.isNotEmpty) {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => IDDetailsScreen(
//                cardImagePath: result.images.first,
//              ),
//            ),
//          );
//        }
//           } catch (e) {
//        ScaffoldMessenger.of(context).showSnackBar(
//          SnackBar(content: Text('Scan failed: ${e.toString()}')),
//        );
//      }
//    }
//
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(title: const Text('Document Scanner')),
//        body: Center(
//          child: _isScanning
//              ? const CircularProgressIndicator()
//              : ElevatedButton(
//            onPressed: () => scanDocument(context),
//            child: const Text('Scan Document'),
//          ),
//        ),
//      );
//    }
// }
