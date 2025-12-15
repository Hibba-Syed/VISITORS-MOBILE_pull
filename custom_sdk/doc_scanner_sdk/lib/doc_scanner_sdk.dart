import 'package:flutter/foundation.dart';
import 'doc_scanner_sdk_platform_interface.dart';

/// Localization configuration for document scanner
/// All parameters are optional with English defaults
class DocumentScannerLocalization {
  // ==================== iOS Specific Strings ====================
  
  // Filter related
  final String iosFilterButtonText;
  final String iosFilterModeText;
  final String iosColorFilterText;
  final String iosGrayscaleFilterText;
  final String iosBlackAndWhiteFilterText;
  final String iosPhotoFilterText;
  
  // Buttons
  final String iosSaveButtonText;
  final String iosAddPageButtonText;
  final String iosCancelButtonText;
  final String iosRetakeButtonText;
  final String iosFlashButtonText;
  final String iosShutterButtonText;
  
  // Messages
  final String iosReadyForNextScanText;
  final String iosProcessingText;
  final String iosScanCompleteText;
  
  // ==================== Android Specific Strings ====================
  
  // Capture mode
  final String androidManualCaptureText;
  final String androidAutoCaptureText;
  final String androidCaptureModeText;
  
  // Instructions
  final String androidPositionDocumentText;
  final String androidScanningHoldSteadyText;
  final String androidMoveCloserText;
  final String androidMoveFartherText;
  final String androidHoldSteadyText;
  final String androidCapturingText;
  
  // Processing
  final String androidProcessingText;
  final String androidCroppingText;
  final String androidEnhancingText;
  
  // Editing
  final String androidCropAndRotateText;
  final String androidAutomaticCropText;
  final String androidNoCropText;
  final String androidManualCropText;
  final String androidRotateText;
  final String androidApplyText;
  final String androidResetText;
  final String androidEditText;
  final String androidDoneText;
  
  // Dialogs
  final String androidDiscardChangesTitle;
  final String androidDiscardChangesMessage;
  final String androidKeepEditingText;
  final String androidDiscardText;
  final String androidDeletePageTitle;
  final String androidDeletePageMessage;
  final String androidDeleteText;
  final String androidCancelText;
  
  // Info messages
  final String androidScanLimitReachedText;
  final String androidNoDocumentDetectedText;
  final String androidDocumentTooSmallText;
  final String androidDocumentTooBigText;
  final String androidPoorLightingText;
  
  // ==================== Common Strings (Both Platforms) ====================
  
  final String scanButtonText;
  final String retakeButtonText;
  final String doneButtonText;
  final String nextButtonText;
  final String backButtonText;
  final String saveButtonText;
  final String cancelButtonText;
  
  const DocumentScannerLocalization({
    // iOS defaults
    this.iosFilterButtonText = 'Filter',
    this.iosFilterModeText = 'Filter Mode',
    this.iosColorFilterText = 'Color',
    this.iosGrayscaleFilterText = 'Grayscale',
    this.iosBlackAndWhiteFilterText = 'Black & White',
    this.iosPhotoFilterText = 'Photo',
    this.iosSaveButtonText = 'Save',
    this.iosAddPageButtonText = 'Add Page',
    this.iosCancelButtonText = 'Cancel',
    this.iosRetakeButtonText = 'Retake',
    this.iosFlashButtonText = 'Flash',
    this.iosShutterButtonText = 'Shutter',
    this.iosReadyForNextScanText = 'Ready for next scan',
    this.iosProcessingText = 'Processing...',
    this.iosScanCompleteText = 'Scan complete',
    
    // Android defaults
    this.androidManualCaptureText = 'Manual',
    this.androidAutoCaptureText = 'Auto',
    this.androidCaptureModeText = 'Capture Mode',
    this.androidPositionDocumentText = 'Position document in frame',
    this.androidScanningHoldSteadyText = 'Scanning... hold steady',
    this.androidMoveCloserText = 'Move closer',
    this.androidMoveFartherText = 'Move farther',
    this.androidHoldSteadyText = 'Hold steady',
    this.androidCapturingText = 'Capturing...',
    this.androidProcessingText = 'Processing...',
    this.androidCroppingText = 'Cropping...',
    this.androidEnhancingText = 'Enhancing...',
    this.androidCropAndRotateText = 'Crop and rotate',
    this.androidAutomaticCropText = 'Automatic crop',
    this.androidNoCropText = 'No crop',
    this.androidManualCropText = 'Manual crop',
    this.androidRotateText = 'Rotate',
    this.androidApplyText = 'Apply',
    this.androidResetText = 'Reset',
    this.androidEditText = 'Edit',
    this.androidDoneText = 'Done',
    this.androidDiscardChangesTitle = 'Discard changes?',
    this.androidDiscardChangesMessage = "Your changes won't be saved",
    this.androidKeepEditingText = 'Keep editing',
    this.androidDiscardText = 'Discard',
    this.androidDeletePageTitle = 'Delete page?',
    this.androidDeletePageMessage = 'This page will be permanently deleted',
    this.androidDeleteText = 'Delete',
    this.androidCancelText = 'Cancel',
    this.androidScanLimitReachedText = 'Scan limit reached',
    this.androidNoDocumentDetectedText = 'No document detected',
    this.androidDocumentTooSmallText = 'Document too small',
    this.androidDocumentTooBigText = 'Document too big',
    this.androidPoorLightingText = 'Poor lighting',
    
    // Common defaults
    this.scanButtonText = 'Scan',
    this.retakeButtonText = 'Retake',
    this.doneButtonText = 'Done',
    this.nextButtonText = 'Next',
    this.backButtonText = 'Back',
    this.saveButtonText = 'Save',
    this.cancelButtonText = 'Cancel',
  });
  
  Map<String, dynamic> toMap() {
    return {
      // iOS
      'iosFilterButtonText': iosFilterButtonText,
      'iosFilterModeText': iosFilterModeText,
      'iosColorFilterText': iosColorFilterText,
      'iosGrayscaleFilterText': iosGrayscaleFilterText,
      'iosBlackAndWhiteFilterText': iosBlackAndWhiteFilterText,
      'iosPhotoFilterText': iosPhotoFilterText,
      'iosSaveButtonText': iosSaveButtonText,
      'iosAddPageButtonText': iosAddPageButtonText,
      'iosCancelButtonText': iosCancelButtonText,
      'iosRetakeButtonText': iosRetakeButtonText,
      'iosFlashButtonText': iosFlashButtonText,
      'iosShutterButtonText': iosShutterButtonText,
      'iosReadyForNextScanText': iosReadyForNextScanText,
      'iosProcessingText': iosProcessingText,
      'iosScanCompleteText': iosScanCompleteText,
      
      // Android
      'androidManualCaptureText': androidManualCaptureText,
      'androidAutoCaptureText': androidAutoCaptureText,
      'androidCaptureModeText': androidCaptureModeText,
      'androidPositionDocumentText': androidPositionDocumentText,
      'androidScanningHoldSteadyText': androidScanningHoldSteadyText,
      'androidMoveCloserText': androidMoveCloserText,
      'androidMoveFartherText': androidMoveFartherText,
      'androidHoldSteadyText': androidHoldSteadyText,
      'androidCapturingText': androidCapturingText,
      'androidProcessingText': androidProcessingText,
      'androidCroppingText': androidCroppingText,
      'androidEnhancingText': androidEnhancingText,
      'androidCropAndRotateText': androidCropAndRotateText,
      'androidAutomaticCropText': androidAutomaticCropText,
      'androidNoCropText': androidNoCropText,
      'androidManualCropText': androidManualCropText,
      'androidRotateText': androidRotateText,
      'androidApplyText': androidApplyText,
      'androidResetText': androidResetText,
      'androidEditText': androidEditText,
      'androidDoneText': androidDoneText,
      'androidDiscardChangesTitle': androidDiscardChangesTitle,
      'androidDiscardChangesMessage': androidDiscardChangesMessage,
      'androidKeepEditingText': androidKeepEditingText,
      'androidDiscardText': androidDiscardText,
      'androidDeletePageTitle': androidDeletePageTitle,
      'androidDeletePageMessage': androidDeletePageMessage,
      'androidDeleteText': androidDeleteText,
      'androidCancelText': androidCancelText,
      'androidScanLimitReachedText': androidScanLimitReachedText,
      'androidNoDocumentDetectedText': androidNoDocumentDetectedText,
      'androidDocumentTooSmallText': androidDocumentTooSmallText,
      'androidDocumentTooBigText': androidDocumentTooBigText,
      'androidPoorLightingText': androidPoorLightingText,
      
      // Common
      'scanButtonText': scanButtonText,
      'retakeButtonText': retakeButtonText,
      'doneButtonText': doneButtonText,
      'nextButtonText': nextButtonText,
      'backButtonText': backButtonText,
      'saveButtonText': saveButtonText,
      'cancelButtonText': cancelButtonText,
    };
  }
  
  /// Create Spanish localization
  static const spanish = DocumentScannerLocalization(
    // iOS
    iosFilterButtonText: 'Filtro',
    iosFilterModeText: 'Modo de filtro',
    iosColorFilterText: 'Color',
    iosGrayscaleFilterText: 'Escala de grises',
    iosBlackAndWhiteFilterText: 'Blanco y negro',
    iosPhotoFilterText: 'Foto',
    iosSaveButtonText: 'Guardar',
    iosAddPageButtonText: 'Agregar página',
    iosCancelButtonText: 'Cancelar',
    iosRetakeButtonText: 'Volver a tomar',
    iosFlashButtonText: 'Flash',
    iosShutterButtonText: 'Obturador',
    iosReadyForNextScanText: 'Listo para el próximo escaneo',
    iosProcessingText: 'Procesando...',
    iosScanCompleteText: 'Escaneo completo',
    
    // Android
    androidManualCaptureText: 'Manual',
    androidAutoCaptureText: 'Automático',
    androidCaptureModeText: 'Modo de captura',
    androidPositionDocumentText: 'Posicione el documento en el marco',
    androidScanningHoldSteadyText: 'Escaneando... mantenga firme',
    androidMoveCloserText: 'Acérquese más',
    androidMoveFartherText: 'Aléjese más',
    androidHoldSteadyText: 'Mantenga firme',
    androidCapturingText: 'Capturando...',
    androidProcessingText: 'Procesando...',
    androidCroppingText: 'Recortando...',
    androidEnhancingText: 'Mejorando...',
    androidCropAndRotateText: 'Recortar y rotar',
    androidAutomaticCropText: 'Recorte automático',
    androidNoCropText: 'Sin recorte',
    androidManualCropText: 'Recorte manual',
    androidRotateText: 'Rotar',
    androidApplyText: 'Aplicar',
    androidResetText: 'Restablecer',
    androidEditText: 'Editar',
    androidDoneText: 'Hecho',
    androidDiscardChangesTitle: '¿Descartar cambios?',
    androidDiscardChangesMessage: 'Sus cambios no se guardarán',
    androidKeepEditingText: 'Seguir editando',
    androidDiscardText: 'Descartar',
    androidDeletePageTitle: '¿Eliminar página?',
    androidDeletePageMessage: 'Esta página se eliminará permanentemente',
    androidDeleteText: 'Eliminar',
    androidCancelText: 'Cancelar',
    androidScanLimitReachedText: 'Límite de escaneo alcanzado',
    androidNoDocumentDetectedText: 'No se detectó ningún documento',
    androidDocumentTooSmallText: 'Documento demasiado pequeño',
    androidDocumentTooBigText: 'Documento demasiado grande',
    androidPoorLightingText: 'Iluminación deficiente',
    
    // Common
    scanButtonText: 'Escanear',
    retakeButtonText: 'Volver a tomar',
    doneButtonText: 'Hecho',
    nextButtonText: 'Siguiente',
    backButtonText: 'Atrás',
    saveButtonText: 'Guardar',
    cancelButtonText: 'Cancelar',
  );
  
  /// Create Urdu localization
  static const urdu = DocumentScannerLocalization(
    // iOS
    iosFilterButtonText: 'فلٹر',
    iosFilterModeText: 'فلٹر موڈ',
    iosColorFilterText: 'رنگ',
    iosGrayscaleFilterText: 'گرے اسکیل',
    iosBlackAndWhiteFilterText: 'سیاہ اور سفید',
    iosPhotoFilterText: 'تصویر',
    iosSaveButtonText: 'محفوظ کریں',
    iosAddPageButtonText: 'صفحہ شامل کریں',
    iosCancelButtonText: 'منسوخ کریں',
    iosRetakeButtonText: 'دوبارہ لیں',
    iosFlashButtonText: 'فلیش',
    iosShutterButtonText: 'شٹر',
    iosReadyForNextScanText: 'اگلے اسکین کے لیے تیار',
    iosProcessingText: 'پروسیسنگ...',
    iosScanCompleteText: 'اسکین مکمل',
    
    // Android
    androidManualCaptureText: 'دستی',
    androidAutoCaptureText: 'خودکار',
    androidCaptureModeText: 'کیپچر موڈ',
    androidPositionDocumentText: 'دستاویز کو فریم میں رکھیں',
    androidScanningHoldSteadyText: 'اسکین ہو رہا ہے... مستحکم رکھیں',
    androidMoveCloserText: 'قریب آئیں',
    androidMoveFartherText: 'دور جائیں',
    androidHoldSteadyText: 'مستحکم رکھیں',
    androidCapturingText: 'کیپچر ہو رہا ہے...',
    androidProcessingText: 'پروسیسنگ...',
    androidCroppingText: 'کراپ ہو رہا ہے...',
    androidEnhancingText: 'بہتر بنایا جا رہا ہے...',
    androidCropAndRotateText: 'کراپ اور گھمائیں',
    androidAutomaticCropText: 'خودکار کراپ',
    androidNoCropText: 'کوئی کراپ نہیں',
    androidManualCropText: 'دستی کراپ',
    androidRotateText: 'گھمائیں',
    androidApplyText: 'لاگو کریں',
    androidResetText: 'ری سیٹ کریں',
    androidEditText: 'ترمیم کریں',
    androidDoneText: 'مکمل',
    androidDiscardChangesTitle: 'تبدیلیاں رد کریں؟',
    androidDiscardChangesMessage: 'آپ کی تبدیلیاں محفوظ نہیں ہوں گی',
    androidKeepEditingText: 'ترمیم جاری رکھیں',
    androidDiscardText: 'رد کریں',
    androidDeletePageTitle: 'صفحہ حذف کریں؟',
    androidDeletePageMessage: 'یہ صفحہ مستقل طور پر حذف ہو جائے گا',
    androidDeleteText: 'حذف کریں',
    androidCancelText: 'منسوخ کریں',
    androidScanLimitReachedText: 'اسکین کی حد پہنچ گئی',
    androidNoDocumentDetectedText: 'کوئی دستاویز نہیں ملی',
    androidDocumentTooSmallText: 'دستاویز بہت چھوٹی ہے',
    androidDocumentTooBigText: 'دستاویز بہت بڑی ہے',
    androidPoorLightingText: 'روشنی کم ہے',
    
    // Common
    scanButtonText: 'اسکین کریں',
    retakeButtonText: 'دوبارہ لیں',
    doneButtonText: 'مکمل',
    nextButtonText: 'اگلا',
    backButtonText: 'پیچھے',
    saveButtonText: 'محفوظ کریں',
    cancelButtonText: 'منسوخ کریں',
  );
  
  /// Create Arabic localization
  static const arabic = DocumentScannerLocalization(
    // iOS
    iosFilterButtonText: 'تصفية',
    iosFilterModeText: 'وضع التصفية',
    iosColorFilterText: 'لون',
    iosGrayscaleFilterText: 'تدرج رمادي',
    iosBlackAndWhiteFilterText: 'أبيض وأسود',
    iosPhotoFilterText: 'صورة',
    iosSaveButtonText: 'حفظ',
    iosAddPageButtonText: 'إضافة صفحة',
    iosCancelButtonText: 'إلغاء',
    iosRetakeButtonText: 'إعادة التقاط',
    iosFlashButtonText: 'فلاش',
    iosShutterButtonText: 'غالق',
    iosReadyForNextScanText: 'جاهز للمسح التالي',
    iosProcessingText: 'معالجة...',
    iosScanCompleteText: 'اكتمل المسح',
    
    // Android
    androidManualCaptureText: 'يدوي',
    androidAutoCaptureText: 'تلقائي',
    androidCaptureModeText: 'وضع الالتقاط',
    androidPositionDocumentText: 'ضع المستند في الإطار',
    androidScanningHoldSteadyText: 'جاري المسح... ثبت الجهاز',
    androidMoveCloserText: 'اقترب أكثر',
    androidMoveFartherText: 'ابتعد أكثر',
    androidHoldSteadyText: 'ثبت الجهاز',
    androidCapturingText: 'جاري الالتقاط...',
    androidProcessingText: 'معالجة...',
    androidCroppingText: 'قص...',
    androidEnhancingText: 'تحسين...',
    androidCropAndRotateText: 'قص وتدوير',
    androidAutomaticCropText: 'قص تلقائي',
    androidNoCropText: 'بدون قص',
    androidManualCropText: 'قص يدوي',
    androidRotateText: 'تدوير',
    androidApplyText: 'تطبيق',
    androidResetText: 'إعادة تعيين',
    androidEditText: 'تحرير',
    androidDoneText: 'تم',
    androidDiscardChangesTitle: 'تجاهل التغييرات؟',
    androidDiscardChangesMessage: 'لن يتم حفظ التغييرات',
    androidKeepEditingText: 'متابعة التحرير',
    androidDiscardText: 'تجاهل',
    androidDeletePageTitle: 'حذف الصفحة؟',
    androidDeletePageMessage: 'سيتم حذف هذه الصفحة نهائياً',
    androidDeleteText: 'حذف',
    androidCancelText: 'إلغاء',
    androidScanLimitReachedText: 'تم الوصول إلى حد المسح',
    androidNoDocumentDetectedText: 'لم يتم اكتشاف مستند',
    androidDocumentTooSmallText: 'المستند صغير جداً',
    androidDocumentTooBigText: 'المستند كبير جداً',
    androidPoorLightingText: 'إضاءة ضعيفة',
    
    // Common
    scanButtonText: 'مسح',
    retakeButtonText: 'إعادة التقاط',
    doneButtonText: 'تم',
    nextButtonText: 'التالي',
    backButtonText: 'رجوع',
    saveButtonText: 'حفظ',
    cancelButtonText: 'إلغاء',
  );
}

/// Document Scanner SDK using native ML Kit (Android) and VisionKit (iOS)
class DocScannerSdk {
  /// Get platform version
  Future<String?> getPlatformVersion() {
    return DocScannerSdkPlatform.instance.getPlatformVersion();
  }

  /// Scan a single document and get both image and PDF
  /// [localization] - Optional localization configuration
  /// Returns Map with 'images' (List<String>) and 'pdf' (String) paths
  Future<dynamic> scanDocument({DocumentScannerLocalization localization = const DocumentScannerLocalization()}) {
    return DocScannerSdkPlatform.instance.scanDocuments(1, localization);
  }

  /// Scan documents and get both images and PDF
  /// [page] - Maximum number of pages to scan (default: 4)
  /// [localization] - Optional localization configuration
  /// Returns Map with 'images' (List<String>) and 'pdf' (String) paths
  Future<dynamic> scanDocuments({
    int page = 4,
    DocumentScannerLocalization localization = const DocumentScannerLocalization(),
  }) {
    return DocScannerSdkPlatform.instance.scanDocuments(page, localization);
  }

  /// Scan a single document and get only the image
  /// [localization] - Optional localization configuration
  /// Returns List<String> with single image file path
  Future<dynamic> scanDocumentAsImage({DocumentScannerLocalization localization = const DocumentScannerLocalization()}) {
    return DocScannerSdkPlatform.instance.scanDocumentsAsImages(1, localization);
  }

  /// Scan documents and get only images
  /// [page] - Maximum number of pages to scan (default: 4)
  /// [localization] - Optional localization configuration
  /// Returns List<String> of image file paths
  Future<dynamic> scanDocumentsAsImages({
    int page = 4,
    DocumentScannerLocalization localization = const DocumentScannerLocalization(),
  }) {
    return DocScannerSdkPlatform.instance.scanDocumentsAsImages(page, localization);
  }

  /// Scan a single document and get only PDF
  /// [localization] - Optional localization configuration
  /// Returns String path to PDF file with single page
  Future<dynamic> scanDocumentAsPdf({DocumentScannerLocalization localization = const DocumentScannerLocalization()}) {
    return DocScannerSdkPlatform.instance.scanDocumentsAsPdf(1, localization);
  }

  /// Scan documents and get only PDF
  /// [page] - Maximum number of pages to scan (default: 4)
  /// [localization] - Optional localization configuration
  /// Returns String path to PDF file
  Future<dynamic> scanDocumentsAsPdf({
    int page = 4,
    DocumentScannerLocalization localization = const DocumentScannerLocalization(),
  }) {
    return DocScannerSdkPlatform.instance.scanDocumentsAsPdf(page, localization);
  }

  /// Get scanned documents as URI (Android only)
  /// [page] - Maximum number of pages to scan (default: 4)
  /// [localization] - Optional localization configuration
  Future<dynamic> scanDocumentsUri({
    int page = 4,
    DocumentScannerLocalization localization = const DocumentScannerLocalization(),
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return DocScannerSdkPlatform.instance.scanDocumentsUri(page, localization);
    } else {
      return Future.error("This feature is only supported on Android");
    }
  }
}
