import 'package:scanbot_sdk/rtu_ui_common.dart';
import 'package:scanbot_sdk/rtu_ui_document.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:visitors/resource/constants/app_colors.dart';

import '../../../utils/app_utils.dart';

class ScanBotDocumentConfig {
   final configuration = DocumentScanningFlow(
    screens: _screenConfig,
    appearance: _appearanceConfig,
    cleanScanningSession: true,
    outputSettings: DocumentScannerOutputSettings(pagesScanLimit: 1),
    localization: DocumentScannerTextLocalization(
      cameraTopBarCancelButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraTopBarCancelButtonTitle'),
      cameraTopBarTitle:
          AppUtils.languageTranslate('scanbot.cameraTopBarTitle'),
      cameraTopGuidance:
          AppUtils.languageTranslate('scanbot.cameraTopGuidance'),
      cameraUserGuidanceStart:
          AppUtils.languageTranslate('scanbot.cameraUserGuidanceStart'),
      cameraUserGuidanceNoDocumentFound: AppUtils.languageTranslate(
          'scanbot.cameraUserGuidanceNoDocumentFound'),
      cameraUserGuidanceBadAspectRatio: AppUtils.languageTranslate(
          'scanbot.cameraUserGuidanceBadAspectRatio'),
      cameraUserGuidanceOrientationMismatch: AppUtils.languageTranslate(
          'scanbot.cameraUserGuidanceOrientationMismatch'),
      cameraUserGuidanceBadAngles:
          AppUtils.languageTranslate('scanbot.cameraUserGuidanceBadAngles'),
      cameraUserGuidanceTooNoisy:
          AppUtils.languageTranslate('scanbot.cameraUserGuidanceTooNoisy'),
      cameraUserGuidanceTextHintOffCenter: AppUtils.languageTranslate(
          'scanbot.cameraUserGuidanceTextHintOffCenter'),
      cameraUserGuidanceTooSmall:
          AppUtils.languageTranslate('scanbot.cameraUserGuidanceTooSmall'),
      cameraUserGuidanceTooDark:
          AppUtils.languageTranslate('scanbot.cameraUserGuidanceTooDark'),
      cameraUserGuidanceEnergySaveMode: AppUtils.languageTranslate(
          'scanbot.cameraUserGuidanceEnergySaveMode'),
      cameraUserGuidanceReadyToCapture: AppUtils.languageTranslate(
          'scanbot.cameraUserGuidanceReadyToCapture'),
      cameraUserGuidanceReadyToCaptureManual: AppUtils.languageTranslate(
          'scanbot.cameraUserGuidanceReadyToCaptureManual'),
      cameraImportButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraImportButtonTitle'),
      cameraTorchOnButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraTorchOnButtonTitle'),
      cameraTorchOffButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraTorchOffButtonTitle'),
      cameraAutoSnapButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraAutoSnapButtonTitle'),
      cameraManualSnapButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraManualSnapButtonTitle'),
      cameraPreviewButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraPreviewButtonTitle'),
      cameraIntroDoneButton:
          AppUtils.languageTranslate('scanbot.cameraIntroDoneButton'),
      cameraIntroTitle: AppUtils.languageTranslate('scanbot.cameraIntroTitle'),
      cameraIntroSubtitle:
          AppUtils.languageTranslate('scanbot.cameraIntroSubtitle'),
      cameraIntroItem1: AppUtils.languageTranslate('scanbot.cameraIntroItem1'),
      cameraIntroItem2: AppUtils.languageTranslate('scanbot.cameraIntroItem2'),
      cameraIntroItem3: AppUtils.languageTranslate('scanbot.cameraIntroItem3'),
      cameraIntroItem4: AppUtils.languageTranslate('scanbot.cameraIntroItem4'),
      cameraProgressOverlayTitle:
          AppUtils.languageTranslate('scanbot.cameraProgressOverlayTitle'),
      cameraCancelAlertTitle:
          AppUtils.languageTranslate('scanbot.cameraCancelAlertTitle'),
      cameraCancelAlertSubtitle:
          AppUtils.languageTranslate('scanbot.cameraCancelAlertSubtitle'),
      cameraCancelNoButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraCancelNoButtonTitle'),
      cameraCancelYesButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraCancelYesButtonTitle'),
      cameraLimitReachedAlertTitle:
          AppUtils.languageTranslate('scanbot.cameraLimitReachedAlertTitle'),
      cameraLimitReachedAlertSubtitle:
          AppUtils.languageTranslate('scanbot.cameraLimitReachedAlertSubtitle'),
      cameraLimitReachedOkButtonTitle:
          AppUtils.languageTranslate('scanbot.cameraLimitReachedOkButtonTitle'),
      acknowledgementScreenBadDocumentHint: AppUtils.languageTranslate(
          'scanbot.acknowledgementScreenBadDocumentHint'),
      acknowledgementRetakeButtonTitle: AppUtils.languageTranslate(
          'scanbot.acknowledgementRetakeButtonTitle'),
      acknowledgementAcceptButtonTitle: AppUtils.languageTranslate(
          'scanbot.acknowledgementAcceptButtonTitle'),
      reviewScreenTitle:
          AppUtils.languageTranslate('scanbot.reviewScreenTitle'),
      reviewTopBarBackButtonTitle:
          AppUtils.languageTranslate('scanbot.reviewTopBarBackButtonTitle'),
      reviewScreenPageCount:
          AppUtils.languageTranslate('scanbot.reviewScreenPageCount'),
      reviewScreenAddButtonTitle:
          AppUtils.languageTranslate('scanbot.reviewScreenAddButtonTitle'),
      reviewScreenRetakeButtonTitle:
          AppUtils.languageTranslate('scanbot.reviewScreenRetakeButtonTitle'),
      reviewScreenCropButtonTitle:
          AppUtils.languageTranslate('scanbot.reviewScreenCropButtonTitle'),
      reviewScreenRotateButtonTitle:
          AppUtils.languageTranslate('scanbot.reviewScreenRotateButtonTitle'),
      reviewScreenDeleteButtonTitle:
          AppUtils.languageTranslate('scanbot.reviewScreenDeleteButtonTitle'),
      reviewScreenSubmitButtonTitle:
          AppUtils.languageTranslate('scanbot.reviewScreenSubmitButtonTitle'),
      reviewScreenDeleteAllButtonTitle: AppUtils.languageTranslate(
          'scanbot.reviewScreenDeleteAllButtonTitle'),
      reviewScreenReorderPagesButtonTitle: AppUtils.languageTranslate(
          'scanbot.reviewScreenReorderPagesButtonTitle'),
      zoomOverlayCancelButtonText:
          AppUtils.languageTranslate('scanbot.zoomOverlayCancelButtonText'),
      reviewDeletePageAlertTitle:
          AppUtils.languageTranslate('scanbot.reviewDeletePageAlertTitle'),
      reviewDeleteAllPagesAlertTitle:
          AppUtils.languageTranslate('scanbot.reviewDeleteAllPagesAlertTitle'),
      reviewDeletePageAlertSubTitle:
          AppUtils.languageTranslate('scanbot.reviewDeletePageAlertSubTitle'),
      reviewDeleteAllPagesAlertSubtitle: AppUtils.languageTranslate(
          'scanbot.reviewDeleteAllPagesAlertSubtitle'),
      reviewDeletePageAlertConfirmButtonTitle: AppUtils.languageTranslate(
          'scanbot.reviewDeletePageAlertConfirmButtonTitle'),
      reviewDeleteAllPagesAlertDeleteButtonTitle: AppUtils.languageTranslate(
          'scanbot.reviewDeleteAllPagesAlertDeleteButtonTitle'),
      reviewDeletePageAlertDeleteRetakeButtonTitle: AppUtils.languageTranslate(
          'scanbot.reviewDeletePageAlertDeleteRetakeButtonTitle'),
      reviewDeletePageAlertCancelButtonTitle: AppUtils.languageTranslate(
          'scanbot.reviewDeletePageAlertCancelButtonTitle'),
      reviewDeleteAllPagesAlertCancelButtonTitle: AppUtils.languageTranslate(
          'scanbot.reviewDeleteAllPagesAlertCancelButtonTitle'),
      acknowledgementTitle:
          AppUtils.languageTranslate('scanbot.acknowledgementTitle'),
      reorderPageTitle: AppUtils.languageTranslate('scanbot.reorderPageTitle'),
      reorderPageGuidanceTitle:
          AppUtils.languageTranslate('scanbot.reorderPageGuidanceTitle'),
      reorderPageText: AppUtils.languageTranslate('scanbot.reorderPageText'),
      reorderTopBarConfirmButtonTitle:
          AppUtils.languageTranslate('scanbot.reorderTopBarConfirmButtonTitle'),
      reorderTopBarCancelButtonTitle:
          AppUtils.languageTranslate('scanbot.reorderTopBarCancelButtonTitle'),
      croppingTopBarConfirmButtonTitle: AppUtils.languageTranslate(
          'scanbot.croppingTopBarConfirmButtonTitle'),
      croppingTopBarCancelButtonTitle:
          AppUtils.languageTranslate('scanbot.croppingTopBarCancelButtonTitle'),
      croppingDetectButtonTitle:
          AppUtils.languageTranslate('scanbot.croppingDetectButtonTitle'),
      croppingRotateButtonTitle:
          AppUtils.languageTranslate('scanbot.croppingRotateButtonTitle'),
      croppingResetButtonTitle:
          AppUtils.languageTranslate('scanbot.croppingResetButtonTitle'),
      croppingScreenTitle:
          AppUtils.languageTranslate('scanbot.croppingScreenTitle'),
      accessibilityDescriptionCameraTopBarIntroButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCameraTopBarIntroButton'),
      accessibilityDescriptionCameraTopBarCancelButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCameraTopBarCancelButton'),
      accessibilityDescriptionCameraImportButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraImportButton'),
      accessibilityDescriptionCameraTorchOnButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraTorchOnButton'),
      accessibilityDescriptionCameraTorchOffButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraTorchOffButton'),
      accessibilityDescriptionCameraShutterButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraShutterButton'),
      accessibilityDescriptionCameraAutoSnapButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraAutoSnapButton'),
      accessibilityDescriptionCameraManualSnapButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCameraManualSnapButton'),
      accessibilityDescriptionCameraPreviewButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraPreviewButton'),
      accessibilityDescriptionCameraIntroDoneButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraIntroDoneButton'),
      accessibilityDescriptionAcknowledgementRetakeButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionAcknowledgementRetakeButton'),
      accessibilityDescriptionAcknowledgementAcceptButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionAcknowledgementAcceptButton'),
      accessibilityDescriptionCroppingTopBarConfirmButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCroppingTopBarConfirmButton'),
      accessibilityDescriptionCroppingTopBarCancelButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCroppingTopBarCancelButton'),
      accessibilityDescriptionCroppingDetectButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCroppingDetectButton'),
      accessibilityDescriptionCroppingRotateButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCroppingRotateButton'),
      accessibilityDescriptionCroppingResetButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCroppingResetButton'),
      accessibilityDescriptionReorderTopBarConfirmButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReorderTopBarConfirmButton'),
      accessibilityDescriptionReorderTopBarCancelButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReorderTopBarCancelButton'),
      accessibilityDescriptionReviewNextPageButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewNextPageButton'),
      accessibilityDescriptionReviewPreviousPageButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewPreviousPageButton'),
      accessibilityDescriptionReviewAddButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewAddButton'),
      accessibilityDescriptionReviewRetakeButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewRetakeButton'),
      accessibilityDescriptionReviewCropButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewCropButton'),
      accessibilityDescriptionReviewRotateButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewRotateButton'),
      accessibilityDescriptionReviewDeleteButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewDeleteButton'),
      accessibilityDescriptionReviewSubmitButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewSubmitButton'),
      accessibilityDescriptionReviewMoreButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewMoreButton'),
      accessibilityDescriptionReviewDeleteAllButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewDeleteAllButton'),
      accessibilityDescriptionReviewReorderPagesButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewReorderPagesButton'),
      accessibilityDescriptionZoomOverlayCancelButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionZoomOverlayCancelButton'),
      accessibilityDescriptionReviewZoomButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionReviewZoomButton'),
      accessibilityDescriptionReviewTopBarBackButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewTopBarBackButton'),
      accessibilityDescriptionReviewDeletePageAlertConfirmButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewDeletePageAlertConfirmButton'),
      accessibilityDescriptionReviewDeleteAllPagesAlertDeleteButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewDeleteAllPagesAlertDeleteButton'),
      accessibilityDescriptionReviewDeletePageAlertDeleteRetakeButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewDeletePageAlertDeleteRetakeButton'),
      accessibilityDescriptionReviewDeletePageAlertCancelButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewDeletePageAlertCancelButton'),
      accessibilityDescriptionReviewDeleteAllPagesAlertCancelButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionReviewDeleteAllPagesAlertCancelButton'),
      accessibilityDescriptionCameraLimitReachedOkButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCameraLimitReachedOkButton'),
      accessibilityDescriptionCameraCancelYesButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraCancelYesButton'),
      accessibilityDescriptionCameraCancelNoButton: AppUtils.languageTranslate(
          'scanbot.accessibilityDescriptionCameraCancelNoButton'),
      cameraPermissionEnableCameraTitle: AppUtils.languageTranslate(
          'scanbot.cameraPermissionEnableCameraTitle'),
      cameraPermissionEnableCameraExplanation: AppUtils.languageTranslate(
          'scanbot.cameraPermissionEnableCameraExplanation'),
      cameraPermissionEnableCameraButton: AppUtils.languageTranslate(
          'scanbot.cameraPermissionEnableCameraButton'),
      cameraPermissionCloseButton:
          AppUtils.languageTranslate('scanbot.cameraPermissionCloseButton'),
      accessibilityDescriptionCameraPermissionEnableCameraButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCameraPermissionEnableCameraButton'),
      accessibilityDescriptionCameraPermissionCloseButton:
          AppUtils.languageTranslate(
              'scanbot.accessibilityDescriptionCameraPermissionCloseButton'),
    ),
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
