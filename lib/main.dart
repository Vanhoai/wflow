import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wflow/common/app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/core/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfigPlus.loadEnvVariables();
  await FirebaseService.initialFirebase();
  await initAppInjection();
  Stripe.publishableKey =
      'pk_test_51Msy89LoJoXEgivefPW8pyHzTPik1CXFh3fE2RDaU3CL29VbUZDb3xhcYm0CfcOWspPknCRJZS686oMV8OPakrPW00w5wRSJrV';
  await Stripe.instance.applySettings();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  HydratedBloc.storage = SecureHydrateStorage(sharedPreferences: sharedPreferences); // initialize HydratedBloc

  FlipperClient flipperClient = FlipperClient.getDefault();
  flipperClient.addPlugin(FlipperNetworkPlugin());
  flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
  flipperClient.addPlugin(FlipperReduxInspectorPlugin());
  flipperClient.start();

  runApp(const App());
}
