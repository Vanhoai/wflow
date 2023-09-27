import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/utils/secure.util.dart';
import 'package:wflow/modules/auth/data/auth.repository.impl.dart';
import 'package:wflow/modules/auth/data/auth.service.dart';
import 'package:wflow/modules/auth/domain/auth.repository.dart';
import 'package:wflow/modules/auth/domain/auth.usecase.dart';
import 'package:logger/logger.dart';

final GetIt instance = GetIt.instance;
late SharedPreferences sharedPreferences;

Future<void> initAppInjection() async {
  // utils
  instance.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sharedPreferences = await SharedPreferences.getInstance();

  // storage
  instance.registerLazySingleton<SecureStorage>(
      () => SecureStorage(flutterSecureStorage: instance<FlutterSecureStorage>()));

  // api
  instance.registerLazySingleton<Agent>(() => Agent(secureStorage: instance.get<SecureStorage>()));

  // services
  instance.registerLazySingleton<AuthService>(() => AuthServiceImpl(agent: instance.get<Agent>()));

  // repositories
  instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authService: instance.get<AuthService>()));

  // use case
  instance.registerLazySingleton<AuthUseCase>(() => AuthUseCaseImpl(authRepository: instance.get<AuthRepository>()));

  // common bloc
  instance.registerLazySingleton<AppLoadingBloc>(() => AppLoadingBloc());
  instance.registerLazySingleton<AppBloc>(() => AppBloc());

  // ! FOR DEBUG ONLY
  bool isDebug = false;
  assert(() {
    isDebug = true;
    return true;
  }());
  if (isDebug) {
    Bloc.observer = AppBlocObserver();
  }
}

class AppBlocObserver extends BlocObserver {
  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
    ),
    level: Level.all,
    filter: ProductionFilter(),
  );

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d('onEvent -- bloc: ${bloc.runtimeType}, event: $event', time: DateTime.now());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition', time: DateTime.now());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('onError -- bloc: ${bloc.runtimeType}, error: $error, stackTrace: $stackTrace', time: DateTime.now());
  }
}
