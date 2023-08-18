import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static LocalAuthentication instance = LocalAuthentication();

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    return await instance.getAvailableBiometrics();
  }

  static Future<bool> signInWithBiometric() async {
    final availableBiometrics = await instance.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.face)) {
      try {
        final bool didAuthenticate = await instance.authenticate(
          localizedReason: 'Please authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
          authMessages: [],
        );
        return didAuthenticate;
      } on PlatformException {
        return false;
      }
    } else {
      return false;
    }
  }
}
