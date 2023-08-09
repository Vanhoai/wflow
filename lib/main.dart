import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:wfow/common/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfigPlus.loadEnvVariables();
  runApp(const App());
}
