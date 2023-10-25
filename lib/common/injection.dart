import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/utils/secure.util.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/modules/auth/data/auth_repository_impl.dart';
import 'package:wflow/modules/auth/data/auth_service.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/main/data/contract/contract_repository_impl.dart';
import 'package:wflow/modules/main/data/contract/contract_service.dart';
import 'package:wflow/modules/main/data/cv/cv_repository_impl.dart';
import 'package:wflow/modules/main/data/cv/cv_services.dart';
import 'package:wflow/modules/main/data/post/post_repository_impl.dart';
import 'package:wflow/modules/main/data/post/post_service.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/cv/cv_repository.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/domain/post/post_repository.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/job_information_bloc/bloc.dart';

import 'videocall/bloc/bloc.dart';

final GetIt instance = GetIt.instance;
late SharedPreferences sharedPreferences;
final FlutterLocalization localization = FlutterLocalization.instance;

Future<void> initAppInjection() async {
  // core
  instance.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SecureStorage>(
    () => SecureStorage(flutterSecureStorage: instance<FlutterSecureStorage>()),
  );
  instance.registerFactory<Agent>(() => Agent(secureStorage: instance.get<SecureStorage>()));

  // auth
  instance.registerLazySingleton<AuthService>(() => AuthServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authService: instance.get<AuthService>()));
  instance.registerLazySingleton<AuthUseCase>(() => AuthUseCaseImpl(authRepository: instance.get<AuthRepository>()));

  // post
  instance.registerLazySingleton<PostService>(() => PostServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(postService: instance.get<PostService>()));
  instance.registerLazySingleton<PostUseCase>(() => PostUseCaseImpl(postRepository: instance.get<PostRepository>()));
  //CV
  instance.registerLazySingleton<CVService>(() => CVServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<CVRepository>(() => CVRepositoryImpl(cvService: instance.get<CVService>()));
  instance.registerLazySingleton<CVUseCase>(() => CVUseCaseImpl(cvRepository: instance.get<CVRepository>()));
  //Contact
  instance.registerLazySingleton<ContractService>(() => ContractServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<ContractRepository>(
      () => ContractRepositoryImpl(contactService: instance.get<ContractService>()));
  instance.registerLazySingleton<ContractUseCase>(
      () => ContractUseCaseImpl(contactRepository: instance.get<ContractRepository>()));
  //Video call connect bloc
  instance.registerLazySingleton<StringeeClient>(() => StringeeClient());
  instance.registerLazySingleton<VideoCallBloc>(() => VideoCallBloc(client: instance.get<StringeeClient>()));

  instance.registerLazySingleton<AppBloc>(() => AppBloc());
  instance.registerLazySingleton<AppLoadingBloc>(() => AppLoadingBloc());
  instance.registerLazySingleton<SecurityBloc>(() => SecurityBloc());
  instance.registerLazySingleton<Time>(() => Time());
  instance.registerSingleton<NavigationService>(NavigationService());

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
    level: Level.verbose,
    filter: ProductionFilter(),
  );

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('onError -- bloc: ${bloc.runtimeType}, error: $error, stackTrace: $stackTrace');
  }
}
