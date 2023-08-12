import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorage({required this.flutterSecureStorage});

  void clear() {
    flutterSecureStorage.deleteAll();
  }

  void write(String key, dynamic data) {
    flutterSecureStorage.write(key: key, value: data);
  }

  dynamic read(String key) {
    return flutterSecureStorage.read(key: key);
  }
}
