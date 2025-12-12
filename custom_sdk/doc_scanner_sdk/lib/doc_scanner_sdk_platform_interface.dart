import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'doc_scanner_sdk_method_channel.dart';

abstract class DocScannerSdkPlatform extends PlatformInterface {
  DocScannerSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static DocScannerSdkPlatform _instance = MethodChannelDocScannerSdk();

  static DocScannerSdkPlatform get instance => _instance;

  static set instance(DocScannerSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<dynamic> scanDocuments(int page) {
    throw UnimplementedError('scanDocuments() has not been implemented.');
  }

  Future<dynamic> scanDocumentsAsImages(int page) {
    throw UnimplementedError('scanDocumentsAsImages() has not been implemented.');
  }

  Future<dynamic> scanDocumentsAsPdf(int page) {
    throw UnimplementedError('scanDocumentsAsPdf() has not been implemented.');
  }

  Future<dynamic> scanDocumentsUri(int page) {
    throw UnimplementedError('scanDocumentsUri() has not been implemented.');
  }
}
