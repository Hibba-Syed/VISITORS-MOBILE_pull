# Localization Guide

## Overview

The Document Scanner SDK supports localization, allowing you to customize the text displayed in the scanner UI for different languages and regions.

---

## Quick Start

### Basic Usage

```dart
import 'package:doc_scanner_sdk/doc_scanner_sdk.dart';

final scanner = DocScannerSdk();

// Create localization configuration
final localization = DocumentScannerLocalization(
  iosFilterButtonText: 'Filtro',           // Spanish
  iosSaveButtonText: 'Guardar',
  iosAddPageButtonText: 'Agregar Página',
  iosCancelButtonText: 'Cancelar',
  scanButtonText: 'Escanear',
  retakeButtonText: 'Volver a tomar',
  doneButtonText: 'Hecho',
);

// Pass localization when scanning
final result = await scanner.scanDocument(
  localization: localization,
);
```

---

## DocumentScannerLocalization Class

### Available Parameters

```dart
class DocumentScannerLocalization {
  // iOS Specific
  final String? iosFilterButtonText;      // Filter button text
  final String? iosSaveButtonText;        // Save button text
  final String? iosAddPageButtonText;     // Add Page button text
  final String? iosCancelButtonText;      // Cancel button text
  
  // Android Specific  
  final String? androidScanningText;      // Scanning progress text
  final String? androidProcessingText;    // Processing text
  
  // Common (both platforms)
  final String? scanButtonText;           // Scan button
  final String? retakeButtonText;         // Retake button
  final String? doneButtonText;           // Done button
}
```

### Constructor

```dart
const DocumentScannerLocalization({
  this.iosFilterButtonText,
  this.iosSaveButtonText,
  this.iosAddPageButtonText,
  this.iosCancelButtonText,
  this.androidScanningText,
  this.androidProcessingText,
  this.scanButtonText,
  this.retakeButtonText,
  this.doneButtonText,
});
```

---

## Usage Examples

### Example 1: Spanish Localization

```dart
final spanishLocalization = DocumentScannerLocalization(
  iosFilterButtonText: 'Filtro',
  iosSaveButtonText: 'Guardar',
  iosAddPageButtonText: 'Agregar Página',
  iosCancelButtonText: 'Cancelar',
  androidScanningText: 'Escaneando...',
  androidProcessingText: 'Procesando...',
  scanButtonText: 'Escanear',
  retakeButtonText: 'Volver a tomar',
  doneButtonText: 'Hecho',
);

await scanner.scanDocument(localization: spanishLocalization);
```

### Example 2: French Localization

```dart
final frenchLocalization = DocumentScannerLocalization(
  iosFilterButtonText: 'Filtre',
  iosSaveButtonText: 'Enregistrer',
  iosAddPageButtonText: 'Ajouter une page',
  iosCancelButtonText: 'Annuler',
  androidScanningText: 'Numérisation...',
  androidProcessingText: 'Traitement...',
  scanButtonText: 'Scanner',
  retakeButtonText: 'Reprendre',
  doneButtonText: 'Terminé',
);

await scanner.scanDocuments(
  page: 5,
  localization: frenchLocalization,
);
```

### Example 3: Urdu Localization

```dart
final urduLocalization = DocumentScannerLocalization(
  iosFilterButtonText: 'فلٹر',
  iosSaveButtonText: 'محفوظ کریں',
  iosAddPageButtonText: 'صفحہ شامل کریں',
  iosCancelButtonText: 'منسوخ کریں',
  androidScanningText: 'سکین ہو رہا ہے...',
  androidProcessingText: 'پروسیسنگ...',
  scanButtonText: 'سکین کریں',
  retakeButtonText: 'دوبارہ لیں',
  doneButtonText: 'مکمل',
);

await scanner.scanDocument(localization: urduLocalization);
```

### Example 4: Arabic Localization

```dart
final arabicLocalization = DocumentScannerLocalization(
  iosFilterButtonText: 'تصفية',
  iosSaveButtonText: 'حفظ',
  iosAddPageButtonText: 'إضافة صفحة',
  iosCancelButtonText: 'إلغاء',
  androidScanningText: 'جاري المسح...',
  androidProcessingText: 'معالجة...',
  scanButtonText: 'مسح',
  retakeButtonText: 'إعادة التقاط',
  doneButtonText: 'تم',
);

await scanner.scanDocument(localization: arabicLocalization);
```

---

## Integration with App Localization

### Using Flutter Intl

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedScanner {
  final BuildContext context;
  
  LocalizedScanner(this.context);
  
  DocumentScannerLocalization get localization {
    final l10n = AppLocalizations.of(context)!;
    
    return DocumentScannerLocalization(
      iosFilterButtonText: l10n.scannerFilterButton,
      iosSaveButtonText: l10n.scannerSaveButton,
      iosAddPageButtonText: l10n.scannerAddPageButton,
      iosCancelButtonText: l10n.scannerCancelButton,
      androidScanningText: l10n.scannerScanningText,
      androidProcessingText: l10n.scannerProcessingText,
      scanButtonText: l10n.scannerScanButton,
      retakeButtonText: l10n.scannerRetakeButton,
      doneButtonText: l10n.scannerDoneButton,
    );
  }
  
  Future<dynamic> scan() async {
    final scanner = DocScannerSdk();
    return await scanner.scanDocument(localization: localization);
  }
}
```

### Using Easy Localization

```dart
import 'package:easy_localization/easy_localization.dart';

DocumentScannerLocalization getLocalization() {
  return DocumentScannerLocalization(
    iosFilterButtonText: 'scanner.filter_button'.tr(),
    iosSaveButtonText: 'scanner.save_button'.tr(),
    iosAddPageButtonText: 'scanner.add_page_button'.tr(),
    iosCancelButtonText: 'scanner.cancel_button'.tr(),
    androidScanningText: 'scanner.scanning_text'.tr(),
    androidProcessingText: 'scanner.processing_text'.tr(),
    scanButtonText: 'scanner.scan_button'.tr(),
    retakeButtonText: 'scanner.retake_button'.tr(),
    doneButtonText: 'scanner.done_button'.tr(),
  );
}

// Usage
await scanner.scanDocument(localization: getLocalization());
```

### Using Custom Translation Service

```dart
class TranslationService {
  static DocumentScannerLocalization getScannerLocalization(String language) {
    final translations = _getTranslations(language);
    
    return DocumentScannerLocalization(
      iosFilterButtonText: translations['filter'],
      iosSaveButtonText: translations['save'],
      iosAddPageButtonText: translations['add_page'],
      iosCancelButtonText: translations['cancel'],
      androidScanningText: translations['scanning'],
      androidProcessingText: translations['processing'],
      scanButtonText: translations['scan'],
      retakeButtonText: translations['retake'],
      doneButtonText: translations['done'],
    );
  }
  
  static Map<String, String> _getTranslations(String language) {
    // Your translation logic here
    switch (language) {
      case 'es':
        return {
          'filter': 'Filtro',
          'save': 'Guardar',
          // ... more translations
        };
      default:
        return {
          'filter': 'Filter',
          'save': 'Save',
          // ... default English
        };
    }
  }
}
```

---

## Platform-Specific Behavior

### Android (ML Kit)

**Customizable Text:**
- ✅ `androidScanningText` - Progress overlay text
- ✅ `androidProcessingText` - Processing text
- ✅ `scanButtonText` - Scan button
- ✅ `retakeButtonText` - Retake button
- ✅ `doneButtonText` - Done button

**Note**: ML Kit scanner has limited text customization. Some system UI elements cannot be localized.

### iOS (VisionKit)

**Customizable Text:**
- ✅ `iosFilterButtonText` - Filter mode button
- ✅ `iosSaveButtonText` - Save button
- ✅ `iosAddPageButtonText` - Add Page button
- ✅ `iosCancelButtonText` - Cancel button
- ✅ `scanButtonText` - Scan button
- ✅ `retakeButtonText` - Retake button
- ✅ `doneButtonText` - Done button

**Note**: VisionKit is a system framework and some UI text is controlled by iOS and follows the device's system language.

---

## Best Practices

### 1. Consistency with App Language

```dart
class ScannerService {
  final Locale currentLocale;
  
  ScannerService(this.currentLocale);
  
  DocumentScannerLocalization get localization {
    // Return localization based on current app locale
    switch (currentLocale.languageCode) {
      case 'es':
        return _spanishLocalization;
      case 'fr':
        return _frenchLocalization;
      default:
        return _englishLocalization;
    }
  }
}
```

### 2. Fallback to English

```dart
DocumentScannerLocalization getLocalizationOrDefault(String? languageCode) {
  if (languageCode == null) {
    return _defaultEnglishLocalization;
  }
  
  return _localizations[languageCode] ?? _defaultEnglishLocalization;
}
```

### 3. Cache Localizations

```dart
class LocalizationCache {
  static final Map<String, DocumentScannerLocalization> _cache = {};
  
  static DocumentScannerLocalization getLocalization(String language) {
    return _cache.putIfAbsent(
      language,
      () => _loadLocalization(language),
    );
  }
}
```

### 4. Validation

```dart
DocumentScannerLocalization createLocalization({
  required String language,
}) {
  // Validate strings are not empty
  assert(filterText.isNotEmpty, 'Filter text cannot be empty');
  
  return DocumentScannerLocalization(
    iosFilterButtonText: filterText,
    // ... other fields
  );
}
```

---

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:doc_scanner_sdk/doc_scanner_sdk.dart';

class MultilingualScanner extends StatefulWidget {
  @override
  State<MultilingualScanner> createState() => _MultilingualScannerState();
}

class _MultilingualScannerState extends State<MultilingualScanner> {
  final _scanner = DocScannerSdk();
  String _currentLanguage = 'en';
  
  // Define localizations for all supported languages
  final Map<String, DocumentScannerLocalization> _localizations = {
    'en': DocumentScannerLocalization(
      iosFilterButtonText: 'Filter',
      iosSaveButtonText: 'Save',
      iosAddPageButtonText: 'Add Page',
      iosCancelButtonText: 'Cancel',
      scanButtonText: 'Scan',
      retakeButtonText: 'Retake',
      doneButtonText: 'Done',
    ),
    'es': DocumentScannerLocalization(
      iosFilterButtonText: 'Filtro',
      iosSaveButtonText: 'Guardar',
      iosAddPageButtonText: 'Agregar Página',
      iosCancelButtonText: 'Cancelar',
      scanButtonText: 'Escanear',
      retakeButtonText: 'Volver a tomar',
      doneButtonText: 'Hecho',
    ),
    // Add more languages as needed
  };
  
  Future<void> _scan() async {
    final localization = _localizations[_currentLanguage];
    
    final result = await _scanner.scanDocument(
      localization: localization,
    );
    
    // Handle result...
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Language selector
          DropdownButton<String>(
            value: _currentLanguage,
            items: _localizations.keys.map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(lang.toUpperCase()),
              );
            }).toList(),
            onChanged: (lang) {
              setState(() => _currentLanguage = lang!);
            },
          ),
          // Scan button
          ElevatedButton(
            onPressed: _scan,
            child: Text('Scan Document'),
          ),
        ],
      ),
    );
  }
}
```

---

## Language Support Matrix

| Language | Code | iOS Support | Android Support |
|----------|------|-------------|-----------------|
| English | en | ✅ | ✅ |
| Spanish | es | ✅ | ✅ |
| French | fr | ✅ | ✅ |
| German | de | ✅ | ✅ |
| Italian | it | ✅ | ✅ |
| Portuguese | pt | ✅ | ✅ |
| Chinese | zh | ✅ | ✅ |
| Japanese | ja | ✅ | ✅ |
| Korean | ko | ✅ | ✅ |
| Arabic | ar | ✅ | ✅ |
| Urdu | ur | ✅ | ✅ |
| Hindi | hi | ✅ | ✅ |

*All languages supported - provide your own translations*

---

## Example Translations

### Complete Localization Templates

#### English (Default)
```dart
const englishLocalization = DocumentScannerLocalization(
  iosFilterButtonText: 'Filter',
  iosSaveButtonText: 'Save',
  iosAddPageButtonText: 'Add Page',
  iosCancelButtonText: 'Cancel',
  androidScanningText: 'Scanning...',
  androidProcessingText: 'Processing...',
  scanButtonText: 'Scan',
  retakeButtonText: 'Retake',
  doneButtonText: 'Done',
);
```

#### Spanish
```dart
const spanishLocalization = DocumentScannerLocalization(
  iosFilterButtonText: 'Filtro',
  iosSaveButtonText: 'Guardar',
  iosAddPageButtonText: 'Agregar Página',
  iosCancelButtonText: 'Cancelar',
  androidScanningText: 'Escaneando...',
  androidProcessingText: 'Procesando...',
  scanButtonText: 'Escanear',
  retakeButtonText: 'Volver a tomar',
  doneButtonText: 'Hecho',
);
```

#### German
```dart
const germanLocalization = DocumentScannerLocalization(
  iosFilterButtonText: 'Filter',
  iosSaveButtonText: 'Speichern',
  iosAddPageButtonText: 'Seite hinzufügen',
  iosCancelButtonText: 'Abbrechen',
  androidScanningText: 'Scannen...',
  androidProcessingText: 'Verarbeitung...',
  scanButtonText: 'Scannen',
  retakeButtonText: 'Wiederholen',
  doneButtonText: 'Fertig',
);
```

---

## Troubleshooting

### Issue: Text Not Changing

**Solution**: Make sure you're passing the localization parameter:
```dart
// ❌ Wrong - no localization passed
await scanner.scanDocument();

// ✅ Correct - localization passed
await scanner.scanDocument(localization: myLocalization);
```

### Issue: Some Text Still in English

**Cause**: Platform limitations - some system UI cannot be customized.

**Solution**: This is expected behavior. Focus on customizing the available text fields.

### Issue: RTL Languages Not Displaying Correctly

**Solution**: Enable RTL support in your app:
```dart
MaterialApp(
  locale: Locale('ar'), // or 'ur', 'he', etc.
  builder: (context, child) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: child!,
    );
  },
)
```

---

## Testing

### Test Different Languages

```dart
void testLocalizations() {
  final languages = ['en', 'es', 'fr', 'de', 'ar'];
  
  for (final lang in languages) {
    final localization = getLocalization(lang);
    
    // Verify all fields are not empty
    assert(localization.scanButtonText != null);
    assert(localization.scanButtonText!.isNotEmpty);
    
    print('✅ $lang localization valid');
  }
}
```

---

## Summary

✅ **Easy Integration**: Simple parameter in scan methods
✅ **Flexible**: Works with any localization package
✅ **Platform Aware**: Separate iOS and Android strings
✅ **Optional**: Defaults to English if not provided
✅ **Type Safe**: Dart class with clear parameters
✅ **Complete Example**: See `main_localized.dart`

---

## Files

- **Example**: `example/lib/main_localized.dart`
- **Documentation**: `LOCALIZATION.md`
- **API**: `lib/doc_scanner_sdk.dart`

Run the example:
```bash
flutter run --target=lib/main_localized.dart
```
