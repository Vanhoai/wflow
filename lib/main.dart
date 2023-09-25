import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wflow/common/app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/core/utils/hydrated.util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required by FlutterConfig
  await FlutterConfigPlus.loadEnvVariables(); // initialize FlutterConfig
  await FirebaseService.initialFirebase(); // initialize Firebase
  await initAppInjection(); // initialize Injection
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  HydratedBloc.storage = SecureHydrateStorage(sharedPreferences: sharedPreferences); // initialize HydratedBloc

  FlipperClient flipperClient = FlipperClient.getDefault();
  flipperClient.addPlugin(FlipperNetworkPlugin(filter: (HttpClientRequest request) {
    String url = '${request.uri}';
    if (url.startsWith('https://via.placeholder.com') || url.startsWith('https://gravatar.com')) {
      return false;
    }
    return true;
  }));
  flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
  flipperClient.start();
  print('FlipperClient is running');
  try {
    runApp(const App());
  } catch (error) {
    FlutterErrorDetails(
      exception: error,
      context: ErrorSummary('Global Error'),
      library: 'main.dart',
      stack: StackTrace.current,
    );
  }
}
