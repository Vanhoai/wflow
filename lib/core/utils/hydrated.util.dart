import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';

class SecureHydrateStorage implements Storage {
  @override
  Future<void> clear() async {
    instance.get<FlutterSecureStorage>().deleteAll();
  }

  @override
  Future<void> close() async {}

  @override
  Future<void> delete(String key) {
    return instance.get<FlutterSecureStorage>().delete(key: key);
  }

  @override
  read(String key) {
    return instance.get<FlutterSecureStorage>().read(key: key);
  }

  @override
  Future<void> write(String key, value) {
    if (value is String) {
      return instance.get<FlutterSecureStorage>().write(key: key, value: value);
    } else {
      // value is Map<String, dynamic>
      final json = value.toString();
      return instance.get<FlutterSecureStorage>().write(key: key, value: json);
    }
  }
}
