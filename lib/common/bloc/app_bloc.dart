import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';
part 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppChangeLanguage>(onAppChangeLanguage);
    on<AppChangeTheme>(onAppChangeTheme);
    on<AppChangeLoading>(onAppChangeLoading);
  }

  FutureOr<void> onAppChangeLanguage(AppChangeLanguage event, Emitter<AppState> emit) async {
    emit(state.copyWith(languageCode: event.languageCode));
  }

  FutureOr<void> onAppChangeTheme(AppChangeTheme event, Emitter<AppState> emit) {
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  FutureOr<void> onAppChangeLoading(AppChangeLoading event, Emitter<AppState> emit) async {
    emit(state.copyWith(isLoading: event.isLoading));
  }
}
