import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/core/utils/secure.util.dart';

part 'event.dart';
part 'state.dart';

class SecurityBloc extends HydratedBloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(onInit()) {
    on<ToggleTouchIDEvent>(onEnableTouchID);
    on<LoginWithTouchIDEvent>(onToggleTouchID);
    on<RememberMeEvent>(onEnableRememberMe);
    on<ClearAllDataEvent>(onClearAll);
    on<SaveCredentialsEvent>(onSaveCredentials);
  }

  static SecurityState onInit() {
    if (sharedPreferences.containsKey('SecurityBloc')) {
      return SecurityState.fromJson(jsonDecode(sharedPreferences.getString('SecurityBloc')!));
    }
    return const SecurityState(touchIDEnabled: false, isRememberMe: false);
  }

  Future<void> onEnableTouchID(ToggleTouchIDEvent event, Emitter<SecurityState> emit) async {
    emit(state.copyWith(touchIDEnabled: event.touchIDEnabled));
  }

  FutureOr<void> onEnableRememberMe(RememberMeEvent event, Emitter<SecurityState> emit) {
    emit(state.copyWith(isRememberMe: event.rememberMe));
  }

  Future<void> onToggleTouchID(LoginWithTouchIDEvent event, Emitter<SecurityState> emit) async {
    final bool isRememberMe = state.isRememberMe;
    if (isRememberMe) {
      final String? email = await instance.get<SecureStorage>().read(AppConstants.usernameKey);
      final String? password = await instance.get<SecureStorage>().read(AppConstants.passwordKey);
      emit(BiometricSuccess(email: email ?? '', password: password ?? ''));
    } else {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification') ?? 'Notification',
          instance.get<AppLocalization>().translate('pleaseRememberCredential') ?? 'Please remember credential');
    }
  }

  Future<void> onSaveCredentials(SaveCredentialsEvent event, Emitter<SecurityState> emit) async {
    await instance.get<SecureStorage>().write(AppConstants.usernameKey, event.email);
    await instance.get<SecureStorage>().write(AppConstants.passwordKey, event.password);
    await onEnableRememberMe(const RememberMeEvent(rememberMe: true), emit);
  }

  void onClearAll(ClearAllDataEvent event, Emitter<SecurityState> emit) async {
    await instance.get<SecureStorage>().delete(AppConstants.usernameKey);
    await instance.get<SecureStorage>().delete(AppConstants.passwordKey);

    emit(const SecurityState(touchIDEnabled: false, isRememberMe: false));
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
