import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static LocalAuthentication instance = LocalAuthentication();

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    return await instance.getAvailableBiometrics();
  }
}
