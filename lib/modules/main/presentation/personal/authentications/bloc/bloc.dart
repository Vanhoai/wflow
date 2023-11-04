import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/authentication/model/request_model.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_entity.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/state.dart';

class AuthenticationsBloc extends Bloc<AuthenticationsEvent, AuthenticationsState> {
  final AuthenticationUseCase authenticationUseCase;
  AuthenticationsBloc({required this.authenticationUseCase}) : super(const AuthenticationsState()) {
    on<StepOneEvent>(stepOne);
    on<StepTwoEvent>(stepTwo);
    on<StepThreeEvent>(stepThree);
    on<CleanData>(cleanData);
    on<FaceMatchEvent>(faceMatch);
  }

  FutureOr<void> stepOne(StepOneEvent event, Emitter<AuthenticationsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final dataFontID = await authenticationUseCase.getFrontID(event.frontID);
    dataFontID.fold(
      (AuthenticationEntity left) {
        if (left.errorCode == 0) {
          emit(state.copyWith(
              stepOne: state.stepOne.copyWith(step: true, messageStep: 'SUCCESS'),
              frontID: event.frontID,
              isLoading: false,
              dataFrontID: left.data[0] as FrontID));
        } else {
          emit(state.copyWith(
            stepOne: state.stepOne.copyWith(step: true, messageStep: left.errorMessage),
            frontID: event.frontID,
            isLoading: false,
          ));
        }
      },
      (Failure right) {
        emit(state.copyWith(
          stepOne: state.stepOne.copyWith(messageStep: 'Error'),
          isLoading: false,
          frontID: event.frontID,
        ));
      },
    );
  }

  FutureOr<void> stepTwo(StepTwoEvent event, Emitter<AuthenticationsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final dataFontID = await authenticationUseCase.getBackID(event.backID);
    dataFontID.fold(
      (AuthenticationEntity left) {
        if (left.errorCode == 0) {
          if ((left.data[0] as BackID).type.contains(state.dataFrontID!.type.split("_")[0])) {
            emit(state.copyWith(
                stepTwo: state.stepOne.copyWith(step: true, messageStep: 'SUCCESS'),
                backID: event.backID,
                isLoading: false,
                dataBackID: left.data[0] as BackID));
          } else {
            emit(state.copyWith(
              stepTwo: state.stepOne.copyWith(step: false, messageStep: ' CCCD/CMND không cùng loại'),
              backID: event.backID,
              isLoading: false,
            ));
          }
        } else {
          emit(state.copyWith(
            stepTwo: state.stepOne.copyWith(step: true, messageStep: left.errorMessage),
            backID: event.backID,
            isLoading: false,
          ));
        }
      },
      (Failure right) {
        emit(state.copyWith(
          stepOne: state.stepOne.copyWith(messageStep: 'Hình chưa chính xác'),
          isLoading: false,
        ));
      },
    );
  }

  FutureOr<void> stepThree(StepThreeEvent event, Emitter<AuthenticationsState> emit) async {
    emit(state.copyWith(face: event.face, stepThree: state.stepThree.copyWith(step: true)));
  }

  FutureOr<void> cleanData(CleanData event, Emitter<AuthenticationsState> emit) {
    print("huy");
    emit(state.copyWith(
        backID: null,
        face: null,
        frontID: null,
        isLoading: false,
        stepOne: const Step(),
        stepThree: const Step(),
        stepTwo: const Step()));
  }

  FutureOr<void> faceMatch(FaceMatchEvent event, Emitter<AuthenticationsState> emit) async {
    emit(state.copyWith(isLoading: true));
    RequestFaceMatch faceMatch = RequestFaceMatch(
        face: state.face!,
        front: state.frontID!,
        back: state.backID!,
        name: state.dataFrontID!.name,
        identifyCode: state.dataFrontID!.id,
        dob: state.dataFrontID!.dob);
    final respond = await authenticationUseCase.faceMatch(faceMatch);
    respond.fold((HttpResponse left) {
      if (left.statusCode == 200) {
        emit(state.copyWith(
          stepOne: state.stepThree.copyWith(messageStep: 'SUCCESS'),
          isLoading: false,
        ));
        emit(const AuthenticationsSuccessState(message: "Cập nhật thông tin thành công"));
      } else {
        emit(state.copyWith(
          stepOne: state.stepThree.copyWith(messageStep: 'Face match fail'),
          isLoading: false,
        ));
      }
    }, (Failure right) {
      emit(state.copyWith(
        stepOne: state.stepThree.copyWith(messageStep: "Something wrong, try again"),
        isLoading: false,
      ));
    });
  }
}
