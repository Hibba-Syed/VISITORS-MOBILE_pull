import 'package:flutter/foundation.dart';
import 'doc_scanner_sdk_platform_interface.dart';

/// Document Scanner SDK using native ML Kit (Android) and VisionKit (iOS)
class DocScannerSdk {
  /// Get platform version
  Future<String?> getPlatformVersion() {
    return DocScannerSdkPlatform.instance.getPlatformVersion();
  }

  /// Scan documents and get both images and PDF
  /// [page] - Maximum number of pages to scan (default: 4)
  /// Returns Map with 'images' (List<String>) and 'pdf' (String) paths
  Future<dynamic> scanDocuments({int page = 4}) {
    return DocScannerSdkPlatform.instance.scanDocuments(page);
  }

  /// Scan documents and get only images
  /// [page] - Maximum number of pages to scan (default: 4)
  /// Returns List<String> of image file paths
  Future<dynamic> scanDocumentsAsImages({int page = 4}) {
    return DocScannerSdkPlatform.instance.scanDocumentsAsImages(page);
  }

  /// Scan documents and get only PDF
  /// [page] - Maximum number of pages to scan (default: 4)
  /// Returns String path to PDF file
  Future<dynamic> scanDocumentsAsPdf({int page = 4}) {
    return DocScannerSdkPlatform.instance.scanDocumentsAsPdf(page);
  }

  /// Get scanned documents as URI (Android only)
  /// [page] - Maximum number of pages to scan (default: 4)
  Future<dynamic> scanDocumentsUri({int page = 4}) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return DocScannerSdkPlatform.instance.scanDocumentsUri(page);
    } else {
      return Future.error("This feature is only supported on Android");
    }
  }
}
