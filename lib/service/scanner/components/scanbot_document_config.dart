import 'package:scanbot_sdk/rtu_ui_common.dart';
import 'package:scanbot_sdk/rtu_ui_document.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:visitors/resource/constants/app_colors.dart';

class ScanBotDocumentConfig {
  static final configuration = DocumentScanningFlow(
    screens: _screenConfig,
    appearance: _appearanceConfig,
    cleanScanningSession: true,
    outputSettings: DocumentScannerOutputSettings(pagesScanLimit: 1),
    localization: DocumentScannerTextLocalization()
  );

  static final DocumentScannerScreens _screenConfig = DocumentScannerScreens(
      camera: CameraScreenConfiguration(
    scannerParameters:
        DocumentScannerParameters(ignoreOrientationMismatch: true),
  ));

  static final DocumentFlowAppearanceConfiguration _appearanceConfig =
      DocumentFlowAppearanceConfiguration(
          bottomBarBackgroundColor:
              ScanbotColor('#${AppColors.primaryColorCode}'),
          navigationBarMode: NavigationBarMode.DARK,
          orientationLockMode: OrientationLockMode.PORTRAIT,
          statusBarMode: StatusBarMode.DARK,
          topBarBackgroundColor:
              ScanbotColor('#${AppColors.primaryColorCode}'));
}
