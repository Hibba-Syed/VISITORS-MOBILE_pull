import 'package:flutter/services.dart';

class RemoveEmojiInputFormatter extends TextInputFormatter {
  static final _emojiRegex = RegExp(
    r'[\u{1F600}-\u{1F64F}]|' // Emoticons
    r'[\u{1F300}-\u{1F5FF}]|' // Symbols & Pictographs
    r'[\u{1F680}-\u{1F6FF}]|' // Transport & Map
    r'[\u{2600}-\u{26FF}]|'   // Misc symbols
    r'[\u{2700}-\u{27BF}]|'   // Dingbats
    r'[\u{FE00}-\u{FE0F}]|'   // Variation Selectors
    r'[\u{1F900}-\u{1F9FF}]|' // Supplemental Symbols and Pictographs
    r'[\u{1F1E6}-\u{1F1FF}]', // Flags
    unicode: true,
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final cleanedText = newValue.text.replaceAll(_emojiRegex, '');
    return newValue.copyWith(
      text: cleanedText,
      selection: updateCursorPosition(cleanedText),
    );
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.collapsed(offset: text.length);
  }
}
