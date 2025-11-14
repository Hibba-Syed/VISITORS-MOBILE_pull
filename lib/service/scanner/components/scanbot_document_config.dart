import 'package:scanbot_sdk/rtu_ui_common.dart';
import 'package:scanbot_sdk/rtu_ui_document.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';

class ScanbotDocumentConfig {
  static final configuration = DocumentScanningFlow(
    screens: _screenConfig,
    appearance: _apperanceConfig,
    cleanScanningSession: true,
    outputSettings: DocumentScannerOutputSettings(pagesScanLimit: 1),
  );

  static final DocumentScannerScreens _screenConfig = DocumentScannerScreens(
      camera: CameraScreenConfiguration(
    scannerParameters:
        DocumentScannerParameters(ignoreOrientationMismatch: true),
  ));

  static final DocumentFlowAppearanceConfiguration _apperanceConfig =
      DocumentFlowAppearanceConfiguration(
          bottomBarBackgroundColor: ScanbotColor('#2F82CE'),
          navigationBarMode: NavigationBarMode.DARK,
          orientationLockMode: OrientationLockMode.PORTRAIT,
          statusBarMode: StatusBarMode.DARK,
          topBarBackgroundColor: ScanbotColor('#2F82CE'));
}
