import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'doc_scanner_sdk_platform_interface.dart';

class MethodChannelDocScannerSdk extends DocScannerSdkPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('doc_scanner_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<dynamic> scanDocuments(int page) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocuments',
      {'page': page},
    );
    return data;
  }

  @override
  Future<dynamic> scanDocumentsAsImages(int page) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocumentsAsImages',
      {'page': page},
    );
    return data;
  }

  @override
  Future<dynamic> scanDocumentsAsPdf(int page) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocumentsAsPdf',
      {'page': page},
    );
    return data;
  }

  @override
  Future<dynamic> scanDocumentsUri(int page) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocumentsUri',
      {'page': page},
    );
    return data;
  }
}
