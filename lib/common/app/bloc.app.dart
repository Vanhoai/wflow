import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

part 'event.app.dart';
part 'state.app.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(onInit()) {
    on<AppChangeLanguage>(onAppChangeLanguage);
    on<AppChangeTheme>(onAppChangeTheme);
    on<SetIsFirstTime>(setIsFirstTime);
    on<AppChangeAuth>(onAppChangeAuth);
    on<RefreshTokenEvent>(onRefreshToken);
    on<AppChangeUser>(onChangeUserEntity);
  }

  static AppState onInit() {
    if (sharedPreferences.containsKey('AppBloc')) {
      return AppState.fromJson(jsonDecode(sharedPreferences.getString('AppBloc')!));
    }

    return AppState(
      authEntity: const AuthEntity(
        accessToken: '',
        refreshToken: '',
        stringeeToken: '',
        isSignIn: false,
      ),
      userEntity: UserEntity.createEmpty(),
    );
  }

  FutureOr<void> onAppChangeLanguage(AppChangeLanguage event, Emitter<AppState> emit) async {
    emit(state.copyWith(languageCode: event.languageCode));
  }

  FutureOr<void> onAppChangeTheme(AppChangeTheme event, Emitter<AppState> emit) {
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  FutureOr<void> setIsFirstTime(SetIsFirstTime event, Emitter<AppState> emit) {
    emit(state.copyWith(isFirstTime: false));
  }

  FutureOr<void> onAppChangeAuth(AppChangeAuth event, Emitter<AppState> emit) {
    emit(state.copyWith(
      authEntity: event.authEntity,
      role: event.role,
      rememberMe: event.rememberMe,
    ));
  }

  FutureOr<void> onRefreshToken(RefreshTokenEvent event, Emitter<AppState> emit) {
    final authEntity = state.authEntity.copyWith(accessToken: event.accessToken, refreshToken: event.refreshToken);
    emit(state.copyWith(authEntity: authEntity));
  }

  FutureOr<void> onChangeUserEntity(AppChangeUser event, Emitter<AppState> emit) {
    emit(state.copyWith(userEntity: event.userEntity));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return state.toJson();
  }
}
