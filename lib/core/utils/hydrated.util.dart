import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureHydrateStorage implements Storage {
  final SharedPreferences sharedPreferences;

  SecureHydrateStorage({required this.sharedPreferences});

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  @override
  Future<void> close() async {}

  @override
  Future<void> delete(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  void read(String key) {
    sharedPreferences.getString(key);
  }

  @override
  Future<void> write(String key, dynamic value) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else {
      await sharedPreferences.setString(key, jsonEncode(value));
    }
  }
}
