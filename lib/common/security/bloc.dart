import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/models/user_model.dart';

part 'event.dart';
part 'state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityState(faceIDEnabled: false, touchIDEnabled: false, user: UserModel.empty())) {
    on<ToggleTouchIDEvent>(onToggleTouchID);
    on<ToggleFaceIDEvent>(onToggleFaceID);
    on<ChangeUserEvent>(onChangeUser);
  }

  void onToggleTouchID(ToggleTouchIDEvent event, Emitter<SecurityState> emit) {
    emit(state.copyWith(touchIDEnabled: event.touchIDEnabled));
  }

  void onToggleFaceID(ToggleFaceIDEvent event, Emitter<SecurityState> emit) {
    emit(state.copyWith(faceIDEnabled: event.faceIDEnabled));
  }

  void onChangeUser(ChangeUserEvent event, Emitter<SecurityState> emit) {
    emit(state.copyWith(user: event.user));
  }
}
