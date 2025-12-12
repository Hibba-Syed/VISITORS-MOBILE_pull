# Single vs Multiple Document Scan

## Overview

The Document Scanner SDK now supports both **single document** and **multiple documents** scanning modes. This gives developers full control over the scanning experience.

---

## API Methods

### Single Document Scan (New)

#### `scanDocument()`
Scans a single document and returns both image and PDF.
```dart
final result = await scanner.scanDocument();
// Returns: Map with 'images' (List with 1 item) and 'pdfUri' (String)
```

#### `scanDocumentAsImage()`
Scans a single document and returns only the image.
```dart
final result = await scanner.scanDocumentAsImage();
// Returns: List<String> with single image path
```

#### `scanDocumentAsPdf()`
Scans a single document and returns only PDF.
```dart
final result = await scanner.scanDocumentAsPdf();
// Returns: Map with 'pdfUri' and 'pageCount' (1)
```

### Multiple Documents Scan (Existing)

#### `scanDocuments({int page = 4})`
Scans multiple documents (up to specified page limit).
```dart
final result = await scanner.scanDocuments(page: 5);
// Returns: Map with 'images' (List) and 'pdfUri' (String)
```

#### `scanDocumentsAsImages({int page = 4})`
Scans multiple documents and returns only images.
```dart
final result = await scanner.scanDocumentsAsImages(page: 5);
// Returns: List<String> of image paths
```

#### `scanDocumentsAsPdf({int page = 4})`
Scans multiple documents and returns only PDF.
```dart
final result = await scanner.scanDocumentsAsPdf(page: 5);
// Returns: Map with 'pdfUri' and 'pageCount'
```

---

## Comparison

| Feature | Single Document | Multiple Documents |
|---------|----------------|-------------------|
| Page Limit | Always 1 | Configurable (default: 4) |
| Scanner UI | Shows single capture | Shows add page option |
| Return Type | Same structure | Same structure |
| Use Case | Quick single scan | Batch scanning |
| User Experience | Faster | More flexible |

---

## Platform Behavior

### Android (ML Kit)
- **Single Document**: Scanner opens with page limit of 1
- **Multiple Documents**: Scanner opens with "Add Page" button visible
- **Mode**: BASE (no auto-enhancement in both cases)

### iOS (VisionKit)
- **Single Document**: Scanner closes after capturing 1 page
- **Multiple Documents**: Scanner shows "Save" and "Add Page" options
- **Filter**: User can select "Photo" mode for unfiltered scans

---

## Usage Examples

### Example 1: Quick Receipt Scanner
```dart
class ReceiptScanner extends StatelessWidget {
  final _scanner = DocScannerSdk();

  Future<void> scanReceipt() async {
    // Single document is perfect for receipts
    final result = await _scanner.scanDocumentAsImage();
    
    if (result != null && result.isNotEmpty) {
      final imagePath = result[0];
      // Process the receipt image
    }
  }
}
```

### Example 2: Multi-Page Document Scanner
```dart
class DocumentScanner extends StatelessWidget {
  final _scanner = DocScannerSdk();

  Future<void> scanContract() async {
    // Multiple pages for contracts/documents
    final result = await _scanner.scanDocuments(page: 10);
    
    if (result != null) {
      final images = result['images'] as List<String>;
      final pdfPath = result['pdfUri'] as String?;
      // Process multi-page document
    }
  }
}
```

### Example 3: User Choice
```dart
class FlexibleScanner extends StatelessWidget {
  final _scanner = DocScannerSdk();

  Future<void> scan({required bool isSinglePage}) async {
    final result = isSinglePage 
        ? await _scanner.scanDocument()
        : await _scanner.scanDocuments(page: 5);
    
    // Handle result...
  }
}
```

---

## Decision Guide

### Use Single Document Scan When:
✅ Scanning receipts
✅ Scanning business cards
✅ Scanning ID cards/driver's licenses
✅ Quick single-page captures
✅ User expects only one page
✅ Faster user experience needed

### Use Multiple Documents Scan When:
✅ Scanning contracts
✅ Scanning books/magazines
✅ Scanning multi-page forms
✅ User may need multiple pages
✅ Batch processing required
✅ Creating multi-page PDFs

---

## UI/UX Recommendations

### Clear Labeling
```dart
ElevatedButton(
  onPressed: () => scanner.scanDocument(),
  child: Text('Scan Single Document'),
)

ElevatedButton(
  onPressed: () => scanner.scanDocuments(),
  child: Text('Scan Multiple Documents'),
)
```

### Context-Aware Defaults
```dart
class SmartScanner {
  Future<void> scan(DocumentType type) async {
    switch (type) {
      case DocumentType.receipt:
      case DocumentType.businessCard:
        return await scanner.scanDocument(); // Single
        
      case DocumentType.contract:
      case DocumentType.book:
        return await scanner.scanDocuments(); // Multiple
    }
  }
}
```

### User Preference
```dart
class PreferenceAwareScanner {
  Future<void> scan() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultToSingle = prefs.getBool('single_scan_default') ?? true;
    
    final result = defaultToSingle
        ? await scanner.scanDocument()
        : await scanner.scanDocuments();
  }
}
```

---

## Technical Implementation

### How It Works

#### Single Document (page = 1)
1. Developer calls `scanDocument()`
2. SDK internally calls platform scanner with `page: 1`
3. Scanner opens with page limit of 1
4. After first capture, scanner automatically closes
5. Returns result with 1 image

#### Multiple Documents (page > 1)
1. Developer calls `scanDocuments(page: 5)`
2. SDK calls platform scanner with `page: 5`
3. Scanner opens with "Add Page" option visible
4. User can capture up to 5 pages
5. Returns result with array of images

---

## Code Structure

```
DocScannerSdk
├── scanDocument()           → scanDocuments(1)
├── scanDocumentAsImage()    → scanDocumentsAsImages(1)
├── scanDocumentAsPdf()      → scanDocumentsAsPdf(1)
├── scanDocuments({page})    → Platform implementation
├── scanDocumentsAsImages({page})
└── scanDocumentsAsPdf({page})
```

The single document methods are convenience wrappers that call the multiple document methods with `page: 1`.

---

## Example App

A complete example is available in:
```
example/lib/main_single_multiple.dart
```

Run it with:
```bash
flutter run --target=lib/main_single_multiple.dart
```

This example demonstrates:
- Single document scan buttons
- Multiple documents scan buttons
- Results display
- iOS filter instructions
- Clean UI with proper labeling

---

## Migration Guide

### If You Were Using Default Behavior

Before:
```dart
// Always opened multi-page scanner
final result = await scanner.scanDocuments();
```

After (recommended):
```dart
// Explicitly choose based on use case
final result = await scanner.scanDocument();      // For single page
// OR
final result = await scanner.scanDocuments();     // For multiple pages
```

### No Breaking Changes
The old API still works exactly the same way:
```dart
// This still works fine
final result = await scanner.scanDocuments(page: 4);
```

---

## Best Practices

### 1. Default to Single
For most apps, single document scanning is the better default:
```dart
// Better UX for most cases
await scanner.scanDocument();
```

### 2. Provide Both Options
Let users choose:
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Scan Mode'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text('Single Document'),
          onTap: () => _scanSingle(),
        ),
        ListTile(
          title: Text('Multiple Documents'),
          onTap: () => _scanMultiple(),
        ),
      ],
    ),
  ),
);
```

### 3. Context Matters
Use the right method for the context:
```dart
// Receipt scanner app
await scanner.scanDocument();

// Document management app  
await scanner.scanDocuments(page: 20);
```

### 4. Clear Expectations
Tell users what to expect:
```dart
Text('Tap to scan a single page')
// vs
Text('Tap to scan multiple pages (up to 5)')
```

---

## Summary

✅ **New Methods**: `scanDocument()`, `scanDocumentAsImage()`, `scanDocumentAsPdf()`
✅ **Works on Both Platforms**: Android (ML Kit) and iOS (VisionKit)
✅ **No Breaking Changes**: Old methods still work
✅ **Better UX**: Single scan is faster for most use cases
✅ **Flexible**: Developers choose what fits their needs
✅ **Well Documented**: Clear examples and guidelines

---

**Recommendation**: Use `scanDocument()` by default unless you specifically need multi-page scanning. This provides the fastest and simplest user experience.
