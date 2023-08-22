import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/models/user.model.dart';
import 'package:wflow/core/utils/secure.util.dart';

part 'event.dart';
part 'state.dart';

class SecurityBloc extends HydratedBloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityState(faceIDEnabled: false, touchIDEnabled: false, user: UserModel.empty())) {
    on<ToggleTouchIDEvent>(onToggleTouchID);
    on<ToggleFaceIDEvent>(onToggleFaceID);
    on<ChangeUserEvent>(onChangeUser);
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

  void onChangeUser(ChangeUserEvent event, Emitter<SecurityState> emit) {
    emit(state.copyWith(user: event.user));
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
