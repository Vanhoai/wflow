import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';

part 'state.app.dart';
part 'event.app.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(onInit()) {
    on<AppChangeLanguage>(onAppChangeLanguage);
    on<AppChangeTheme>(onAppChangeTheme);
  }

  static AppState onInit() {
    if (sharedPreferences.containsKey("AppBloc")) {
      return AppState.fromJson(jsonDecode(sharedPreferences.getString("AppBloc")!));
    }

    return const AppState();
  }

  FutureOr<void> onAppChangeLanguage(AppChangeLanguage event, Emitter<AppState> emit) async {
    emit(state.copyWith(languageCode: event.languageCode));
  }

  FutureOr<void> onAppChangeTheme(AppChangeTheme event, Emitter<AppState> emit) {
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    print("State: $state");
    return state.toJson();
  }
}
