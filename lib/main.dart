import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:wfow/common/app.dart';
import 'package:wfow/common/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required by FlutterConfig
  await FlutterConfigPlus.loadEnvVariables(); // initialize FlutterConfig
  await initAppInjection(); // initialize injection
  runApp(const App());
}
