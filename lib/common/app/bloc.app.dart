import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';

part 'state.app.dart';
part 'event.app.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(onInit()) {
    on<AppChangeLanguage>(onAppChangeLanguage);
    on<AppChangeTheme>(onAppChangeTheme);
    on<SetIsFirstTime>(setIsFirstTime);
    on<AppChangeAuth>(onAppChangeAuth);
    on<RefreshTokenEvent>(onRefreshToken);
  }

  static AppState onInit() {
    if (sharedPreferences.containsKey('AppBloc')) {
      return AppState.fromJson(jsonDecode(sharedPreferences.getString('AppBloc')!));
    }

    return const AppState(
      authEntity: AuthEntity(
        accessToken: '',
        refreshToken: '',
        isSignIn: false,
        user: User(
          id: 0,
          name: '',
          role: 0,
          age: 0,
          address: '',
          email: '',
          phone: '',
          isVerify: false,
          avatar: '',
          business: 0,
        ),
      ),
    );
  }

  FutureOr<void> onAppChangeLanguage(AppChangeLanguage event, Emitter<AppState> emit) async {
    localization.translate(event.languageCode);
    emit(state.copyWith(languageCode: event.languageCode));
  }

  FutureOr<void> onAppChangeTheme(AppChangeTheme event, Emitter<AppState> emit) {
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  FutureOr<void> setIsFirstTime(SetIsFirstTime event, Emitter<AppState> emit) {
    emit(state.copyWith(isFirstTime: false));
  }

  FutureOr<void> onAppChangeAuth(AppChangeAuth event, Emitter<AppState> emit) {
    emit(state.copyWith(authEntity: event.authEntity));
  }

  FutureOr<void> onRefreshToken(RefreshTokenEvent event, Emitter<AppState> emit) {
    final authEntity = state.authEntity.copyWith(accessToken: event.accessToken, refreshToken: event.refreshToken);
    emit(state.copyWith(authEntity: authEntity));
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
