import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/state.dart';

class AuthenticationsBloc extends Bloc<AuthenticationsEvent, AuthenticationsState> {
  AuthenticationsBloc() : super(const AuthenticationsState()) {
    on<StepOneEvent>(stepOne);
    on<StepTwoEvent>(stepTwo);
    on<StepThreeEvent>(stepThree);
  }

  FutureOr<void> stepOne(StepOneEvent event, Emitter<AuthenticationsState> emit) {
    emit(state.copyWith(stepOne: true, fontID: event.fontID));
  }

  FutureOr<void> stepTwo(StepTwoEvent event, Emitter<AuthenticationsState> emit) {
    emit(state.copyWith(stepTwo: true, backID: event.backID));
  }

  FutureOr<void> stepThree(StepThreeEvent event, Emitter<AuthenticationsState> emit) {
    emit(state.copyWith(stepThree: true, face: event.face));
  }
}
