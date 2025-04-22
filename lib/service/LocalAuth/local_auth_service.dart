import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

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
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint("Authentication Error: $e");
      return false;
    }
  }
}
