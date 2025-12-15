import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'doc_scanner_sdk_platform_interface.dart';
import 'doc_scanner_sdk.dart';

class MethodChannelDocScannerSdk extends DocScannerSdkPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('doc_scanner_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<dynamic> scanDocuments(int page, DocumentScannerLocalization localization) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocuments',
      {
        'page': page,
        'localization': localization.toMap(),
      },
    );
    return data;
  }

  @override
  Future<dynamic> scanDocumentsAsImages(int page, DocumentScannerLocalization localization) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocumentsAsImages',
      {
        'page': page,
        'localization': localization.toMap(),
      },
    );
    return data;
  }

  @override
  Future<dynamic> scanDocumentsAsPdf(int page, DocumentScannerLocalization localization) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocumentsAsPdf',
      {
        'page': page,
        'localization': localization.toMap(),
      },
    );
    return data;
  }

  @override
  Future<dynamic> scanDocumentsUri(int page, DocumentScannerLocalization localization) async {
    final data = await methodChannel.invokeMethod<dynamic>(
      'scanDocumentsUri',
      {
        'page': page,
        'localization': localization.toMap(),
      },
    );
    return data;
  }
}
