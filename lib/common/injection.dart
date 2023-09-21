import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/utils/secure.util.dart';
import 'package:wflow/modules/auth/data/auth.repository.impl.dart';
import 'package:wflow/modules/auth/data/auth.service.dart';
import 'package:wflow/modules/auth/domain/auth.repository.dart';
import 'package:wflow/modules/auth/domain/auth.usecase.dart';

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
}
