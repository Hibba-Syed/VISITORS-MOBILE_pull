import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class EncryptionHelper {
  static const keyHex = "29f79b404c9974e027a4f0ec8f2f4c38";
  static const ivHex = "e0caf19491a698a9e3b0a077015ce5f1";
  /// Encrypts [data] and returns a URI-encoded Base64 string
  static String encryptPayload(Map<String, dynamic> data,) {
    // Convert inner 'vendors' map to a string
    final fixed = (data['filter']!=null)?{"filter":jsonEncode(data["filter"])}:(data["vendors"]==null)?data:{
      "vendors": jsonEncode(data["vendors"])
    };
    final jsonStr = jsonEncode(fixed);

    final key = encrypt.Key(Uint8List.fromList(hex.decode(keyHex)));
    final iv = encrypt.IV(Uint8List.fromList(hex.decode(ivHex)));

    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );

    final encrypted = encrypter.encrypt(jsonStr, iv: iv);
    final xyz = Uri.encodeComponent(encrypted.base64);

    debugPrint('Encrypted (XYZ): $xyz');
    return xyz;
  }

  /// Decrypts a URI-encoded Base64 string using hex key and IV
  static String decryptFromXYZ(String encryptedBase64, String hexKey, String hexIv) {
    final encrypted = encrypt.Encrypted.fromBase64(Uri.decodeComponent(encryptedBase64));
    final key = encrypt.Key(Uint8List.fromList(hex.decode(hexKey)));
    final iv = encrypt.IV(Uint8List.fromList(hex.decode(hexIv)));

    final encrypter =
    encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    debugPrint("Decrypted JSON: $decrypted");

    return decrypted;
  }

  /// Copies [text] to clipboard
  static void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}