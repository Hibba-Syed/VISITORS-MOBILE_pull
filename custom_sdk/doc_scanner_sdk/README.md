# Document Scanner SDK

A simple Flutter plugin for document scanning using native APIs:
- **Android**: Google ML Kit Document Scanner API  
- **iOS**: VisionKit (VNDocumentCameraViewController)

## Features

✅ Native document scanning UI  
✅ Automatic edge detection  
✅ Perspective correction  
✅ Multi-page scanning  
✅ Export as Images  
✅ Export as PDF  

## Installation

```yaml
dependencies:
  doc_scanner_sdk: ^1.0.0
```

## Setup

### Android
Minimum SDK 21. No additional setup required.

### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>Camera is required for document scanning</string>
```

## Usage

```dart
import 'package:doc_scanner_sdk/doc_scanner_sdk.dart';

final scanner = DocScannerSdk();

// Scan and get both images and PDF
final result = await scanner.scanDocuments(page: 5);
print(result['images']); // List of image paths
print(result['pdfUri']); // PDF path

// Scan as images only
final images = await scanner.scanDocumentsAsImages(page: 5);

// Scan as PDF only
final pdf = await scanner.scanDocumentsAsPdf(page: 5);
```

## API

| Method | Returns |
|--------|---------|
| `scanDocuments({page})` | `{images, pdfUri, pageCount}` |
| `scanDocumentsAsImages({page})` | `List<String>` image paths |
| `scanDocumentsAsPdf({page})` | `{pdfPath, pageCount}` |

## License
MIT
