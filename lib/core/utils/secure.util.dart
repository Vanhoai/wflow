import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorage({required this.flutterSecureStorage});

  Future<void> clear() async {
    await flutterSecureStorage.deleteAll();
  }

  Future<void> write(String key, dynamic data) async {
    await flutterSecureStorage.write(key: key, value: data);
  }

  Future<dynamic> read(String key) async {
    return await flutterSecureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    await flutterSecureStorage.delete(key: key);
  }
}
