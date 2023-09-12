import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/utils/secure.util.dart';

part 'event.dart';
part 'state.dart';

class SecurityBloc extends HydratedBloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(onInit()) {
    on<ToggleTouchIDEvent>(onToggleTouchID);
    on<ToggleFaceIDEvent>(onToggleFaceID);
  }

  static SecurityState onInit() {
    if (sharedPreferences.containsKey("SecurityBloc")) {
      return SecurityState.fromJson(jsonDecode(sharedPreferences.getString("SecurityBloc")!));
    }
    return const SecurityState(touchIDEnabled: false, faceIDEnabled: false);
  }

  Future<void> onToggleTouchID(ToggleTouchIDEvent event, Emitter<SecurityState> emit) async {
    if (event.touchIDEnabled) {
      instance.get<SecureStorage>().delete(AppConstants.keySignInWithBiometric);
      instance.get<SecureStorage>().delete(AppConstants.keyPasswordSignInWithBiometric);
      emit(state.copyWith(touchIDEnabled: false));
    } else {
      instance.get<SecureStorage>().write(AppConstants.keySignInWithBiometric, "hoaitv241223@gmail.com");
      instance.get<SecureStorage>().write(AppConstants.keyPasswordSignInWithBiometric, "hoaitv241223");
      emit(state.copyWith(touchIDEnabled: true));
    }
  }

  void onToggleFaceID(ToggleFaceIDEvent event, Emitter<SecurityState> emit) {
    if (event.faceIDEnabled) {
      emit(state.copyWith(faceIDEnabled: false));
    } else {
      emit(state.copyWith(faceIDEnabled: true));
    }
  }

  @override
  SecurityState? fromJson(Map<String, dynamic> json) {
    return SecurityState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SecurityState state) {
    return state.toJson();
  }
}
