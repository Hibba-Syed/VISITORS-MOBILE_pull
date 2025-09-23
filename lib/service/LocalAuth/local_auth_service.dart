import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:visitors/utils/app_utils.dart';

class LocalAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Check if the device supports biometric authentication
  Future<bool> hasBiometricSupport() async {
    return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
  }

  /// Authenticate user
  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: AppUtils.languageTranslate('pleaseAuthenticateToProceed'),
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint( "${AppUtils.languageTranslate('authenticationError')} $e");
      return false;
    }
  }
}
