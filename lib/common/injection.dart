import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wflow/common/bloc/app_bloc.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/utils/secure_storage.dart';
import 'package:wflow/modules/auth/data/auth_repository_impl.dart';
import 'package:wflow/modules/auth/data/auth_service.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppInjection() async {
  // utils
  instance.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

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
  instance.registerLazySingleton<AppBloc>(() => AppBloc());
  instance.registerLazySingleton<AppLoadingBloc>(() => AppLoadingBloc());
  instance.registerLazySingleton<SecurityBloc>(() => SecurityBloc());
}
