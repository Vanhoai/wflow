import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/utils/string.util.dart';
import 'package:wflow/core/utils/secure.util.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/modules/auth/data/auth_repository_impl.dart';
import 'package:wflow/modules/auth/data/auth_service.dart';
import 'package:wflow/modules/auth/domain/auth_repository.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/main/data/authentication/authentication_repository_impl.dart';
import 'package:wflow/modules/main/data/authentication/authentication_service.dart';
import 'package:wflow/modules/main/data/balance/balance_repository_impl.dart';
import 'package:wflow/modules/main/data/balance/balance_service.dart';
import 'package:wflow/modules/main/data/category/category_repository_impl.dart';
import 'package:wflow/modules/main/data/category/category_service.dart';
import 'package:wflow/modules/main/data/company/company_repository_impl.dart';
import 'package:wflow/modules/main/data/company/company_service.dart';
import 'package:wflow/modules/main/data/contract/contract_repository_impl.dart';
import 'package:wflow/modules/main/data/contract/contract_service.dart';
import 'package:wflow/modules/main/data/cv/cv_repository_impl.dart';
import 'package:wflow/modules/main/data/cv/cv_services.dart';
import 'package:wflow/modules/main/data/feedback/feedback_repository_impl.dart';
import 'package:wflow/modules/main/data/feedback/feedback_service.dart';
import 'package:wflow/modules/main/data/media/media_repository_impl.dart';
import 'package:wflow/modules/main/data/media/media_service.dart';
import 'package:wflow/modules/main/data/post/post_repository_impl.dart';
import 'package:wflow/modules/main/data/post/post_service.dart';
import 'package:wflow/modules/main/data/report/report_repository_impl.dart';
import 'package:wflow/modules/main/data/report/report_service.dart';
import 'package:wflow/modules/main/data/room/room_repository_impl.dart';
import 'package:wflow/modules/main/data/room/room_service.dart';
import 'package:wflow/modules/main/data/task/task_repository_impl.dart';
import 'package:wflow/modules/main/data/task/task_service.dart';
import 'package:wflow/modules/main/data/tracking/tracking_repository_impl.dart';
import 'package:wflow/modules/main/data/tracking/tracking_service.dart';
import 'package:wflow/modules/main/data/user/user_repository_impl.dart';
import 'package:wflow/modules/main/data/user/user_service.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_repository.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_usecase.dart';
import 'package:wflow/modules/main/domain/balance/balance_repository.dart';
import 'package:wflow/modules/main/domain/balance/balance_usecase.dart';
import 'package:wflow/modules/main/domain/category/category_repository.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/company/company_repository.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/cv/cv_repository.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_repository.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_usecase.dart';
import 'package:wflow/modules/main/domain/media/media_repository.dart';
import 'package:wflow/modules/main/domain/media/media_usecase.dart';
import 'package:wflow/modules/main/domain/post/post_repository.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/domain/report/report_repository.dart';
import 'package:wflow/modules/main/domain/report/report_usecase.dart';
import 'package:wflow/modules/main/domain/room/room_repository.dart';
import 'package:wflow/modules/main/domain/room/room_usecase.dart';
import 'package:wflow/modules/main/domain/task/task_repository.dart';
import 'package:wflow/modules/main/domain/task/task_usecase.dart';
import 'package:wflow/modules/main/domain/tracking/tracking_repository.dart';
import 'package:wflow/modules/main/domain/tracking/tracking_usecase.dart';
import 'package:wflow/modules/main/domain/user/user_repository.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/bloc.dart';

import 'videocall/bloc/bloc.dart';

final GetIt instance = GetIt.instance;
late SharedPreferences sharedPreferences;

Future<void> initAppInjection() async {
  // core
  instance.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  instance.registerSingleton<AppLocalization>(AppLocalization(const Locale('vi', 'VN')));

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

  // CV
  instance.registerLazySingleton<CVService>(() => CVServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<CVRepository>(() => CVRepositoryImpl(cvService: instance.get<CVService>()));
  instance.registerLazySingleton<CVUseCase>(() => CVUseCaseImpl(cvRepository: instance.get<CVRepository>()));

  // Company
  instance.registerLazySingleton<CompanyService>(() => CompanyServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<CompanyRepository>(
      () => CompanyRepositoryImpl(companyService: instance.get<CompanyService>()));
  instance.registerLazySingleton<CompanyUseCase>(
    () => CompanyUseCaseImpl(companyRepository: instance.get<CompanyRepository>()),
  );

  // Category
  instance.registerLazySingleton<CategoryService>(() => CategoryServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(categoryService: instance.get<CategoryService>()));
  instance.registerLazySingleton<CategoryUseCase>(
    () => CategoryUseCaseImpl(categoryRepository: instance.get<CategoryRepository>()),
  );

  // Contract
  instance.registerLazySingleton<ContractService>(() => ContractServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<ContractRepository>(
      () => ContractRepositoryImpl(contactService: instance.get<ContractService>()));
  instance.registerLazySingleton<ContractUseCase>(
      () => ContractUseCaseImpl(contactRepository: instance.get<ContractRepository>()));

  // Task
  instance.registerLazySingleton<TaskService>(() => TaskServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(taskService: instance.get<TaskService>()));
  instance.registerLazySingleton<TaskUseCase>(() => TaskUseCaseImpl(taskRepository: instance.get<TaskRepository>()));

  // Category
  instance.registerLazySingleton<RoomService>(() => RoomServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<RoomRepository>(() => RoomRepositoryImpl(roomService: instance.get<RoomService>()));
  instance.registerLazySingleton<RoomUseCase>(() => RoomUseCaseImpl(roomRepository: instance.get<RoomRepository>()));

  // Authentication
  instance.registerLazySingleton<AuthenticationService>(() => AuthenticationServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(authenticationService: instance.get<AuthenticationService>()));
  instance.registerLazySingleton<AuthenticationUseCase>(
      () => AuthenticationUseCaseImpl(authenticationRepository: instance.get<AuthenticationRepository>()));

  // Auth bloc
  instance.registerLazySingleton<AuthenticationsBloc>(
      () => AuthenticationsBloc(authenticationUseCase: instance.get<AuthenticationUseCase>()));

  // media
  instance.registerLazySingleton<MediaService>(() => MediaServiceImpl(agent: instance.get<Agent>()));
  instance
      .registerLazySingleton<MediaRepository>(() => MediaRepositoryImpl(mediaService: instance.get<MediaService>()));
  instance.registerLazySingleton<MediaUseCase>(
    () => MediaUseCaseImpl(mediaRepository: instance.get<MediaRepository>()),
  );

  // balance
  instance.registerLazySingleton<BalanceService>(() => BalanceServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<BalanceRepository>(
      () => BalanceRepositoryImpl(balanceService: instance.get<BalanceService>()));
  instance.registerLazySingleton<BalanceUseCase>(
      () => BalanceUseCaseImpl(balanceRepository: instance.get<BalanceRepository>()));

  // tracking
  instance.registerLazySingleton<TrackingService>(() => TrackingServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<TrackingRepository>(
      () => TrackingRepositoryImpl(trackingService: instance.get<TrackingService>()));
  instance.registerLazySingleton<TrackingUseCase>(
      () => TrackingUseCaseImpl(trackingRepository: instance.get<TrackingRepository>()));

  // report
  instance.registerLazySingleton<ReportService>(() => ReportServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<ReportRepository>(
      () => ReportRepositoryImpl(reportService: instance.get<ReportService>()));
  instance.registerLazySingleton<ReportUseCase>(
      () => ReportUseCaseImpl(reportRepository: instance.get<ReportRepository>()));
  // Video call connect bloc
  instance.registerLazySingleton<StringeeClient>(() => StringeeClient());
  instance.registerLazySingleton<VideoCallBloc>(() => VideoCallBloc(client: instance.get<StringeeClient>()));

  //Task Bloc
  instance.registerLazySingleton<TaskBloc>(
    () => TaskBloc(taskUseCase: instance.get<TaskUseCase>(), contractUseCase: instance.get<ContractUseCase>()),
  );
  instance.registerLazySingleton<AppBloc>(() => AppBloc());
  instance.registerLazySingleton<BookmarkBloc>(() => BookmarkBloc(postUseCase: instance.get<PostUseCase>()));
  instance.registerLazySingleton<AppLoadingBloc>(() => AppLoadingBloc());
  instance.registerLazySingleton<SecurityBloc>(() => SecurityBloc());
  instance.registerLazySingleton<Time>(() => Time());
  instance.registerSingleton<NavigationService>(NavigationService());

  // USER
  instance.registerLazySingleton<UserService>(() => UserServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userService: instance.get<UserService>()));
  instance.registerLazySingleton<UserUseCase>(() => UserUseCaseImpl(userRepository: instance.get<UserRepository>()));

  // FEEDBACK
  instance.registerLazySingleton<FeedbackService>(() => FeedbackServiceImpl(agent: instance.get<Agent>()));
  instance.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImpl(feedbackService: instance.get<FeedbackService>()));
  instance.registerLazySingleton<FeedbackUseCase>(
      () => FeedbackUseCaseImpl(feedbackRepository: instance.get<FeedbackRepository>()));

  //Money Format
  instance.registerLazySingleton<NumberFormat>(() => NumberFormat.currency(locale: 'vi_VN', symbol: ''));
  instance.registerLazySingleton<ConvertString>(() => ConvertString());
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
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
    ),
    level: Level.verbose,
    filter: ProductionFilter(),
  );

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
