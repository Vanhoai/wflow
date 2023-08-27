import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/core/utils/hydrated.util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required by FlutterConfig
  await FlutterConfigPlus.loadEnvVariables(); // initialize FlutterConfig
  await FirebaseService.initialFirebase(); // initialize Firebase
  await initAppInjection(); // initialize Injection
  HydratedBloc.storage = SecureHydrateStorage(); // initialize HydratedBloc
  runApp(const App());
}
