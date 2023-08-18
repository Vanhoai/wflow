import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/models/user.model.dart';

part 'event.dart';
part 'state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityState(faceIDEnabled: false, touchIDEnabled: false, user: UserModel.empty())) {
    on<ToggleTouchIDEvent>(onToggleTouchID);
    on<ToggleFaceIDEvent>(onToggleFaceID);
    on<ChangeUserEvent>(onChangeUser);
  }

  Future<void> onToggleTouchID(ToggleTouchIDEvent event, Emitter<SecurityState> emit) async {
    if (event.touchIDEnabled) {
      emit(state.copyWith(touchIDEnabled: false));
    } else {
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
}
