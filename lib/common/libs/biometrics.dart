import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class BiometricsUtil {
  static LocalAuthentication? _localAuthentication;
  static LocalAuthentication get auth => _localAuthentication ??= LocalAuthentication();

  static Future<bool> get canAuthenticate async {
    var value = await auth.canCheckBiometrics && await auth.isDeviceSupported();
    return value;
  }

  static Future<List<BiometricType>> get availableBiometrics async {
    List<BiometricType> values = (await canAuthenticate) ? await auth.getAvailableBiometrics() : const [];
    return values;
  }

  static void cancelAuthentication() {
    _localAuthentication?.stopAuthentication();
    _localAuthentication = null;
  }

  static Future<bool> authenticate(BuildContext context) async {
    try {
      var value = await availableBiometrics.then((value) async {
        if (value.isNotEmpty) {
          return await auth.authenticate(
            localizedReason: 'Please authenticate to complete your transaction',
            authMessages: <AuthMessages>[
              const AndroidAuthMessages(
                biometricHint: 'Biometric',
                cancelButton: 'Cancel',
                biometricNotRecognized: 'Biometric not recognized',
                biometricRequiredTitle: 'Biometric required',
                biometricSuccess: 'Biometric success',
                goToSettingsButton: 'Go to settings',
                deviceCredentialsRequiredTitle: 'Device credentials required',
                deviceCredentialsSetupDescription: 'Please set up your PIN, pattern or password',
                goToSettingsDescription: 'Please setup your device credentials',
                signInTitle: 'Sign in',
              ),
              const IOSAuthMessages(
                cancelButton: 'Cancel',
                goToSettingsButton: 'Go to settings',
                goToSettingsDescription: 'Please set up your Touch ID.',
                lockOut: 'Please reenable your Touch ID',
                localizedFallbackTitle: 'Please enter your password',
              )
            ],
            options: const AuthenticationOptions(
              stickyAuth: true,
              sensitiveTransaction: true,
              useErrorDialogs: false,
            ),
          );
        }
        return false;
      });
      return value;
    } on PlatformException catch (e) {
      print(e.message.toString());
      cancelAuthentication();
    } catch (e) {
      cancelAuthentication();
    }
    return false;
  }
}
