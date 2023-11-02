import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/authentication/authentication_entity.dart';

class Step extends Equatable {
  final bool step;
  final String messageStep;

  const Step({this.step = false, this.messageStep = ''});

  Step copyWith({bool? step, String? messageStep}) {
    return Step(step: step ?? this.step, messageStep: messageStep ?? this.messageStep);
  }

  @override
  List<Object?> get props => [step, messageStep];
}

class AuthenticationsState extends Equatable {
  final Step stepOne;
  final Step stepTwo;
  final Step stepThree;
  final bool isLoading;
  final File? frontID;
  final File? backID;
  final File? face;
  final FrontID? dataFrontID;
  final BackID? dataBackID;
  const AuthenticationsState(
      {this.stepOne = const Step(),
      this.stepTwo = const Step(),
      this.stepThree = const Step(),
      this.isLoading = false,
      this.frontID,
      this.backID,
      this.face,
      this.dataFrontID,
      this.dataBackID});
  AuthenticationsState copyWith({
    Step? stepOne,
    Step? stepTwo,
    Step? stepThree,
    bool? isLoading,
    File? frontID,
    File? backID,
    File? face,
    FrontID? dataFrontID,
    BackID? dataBackID,
  }) {
    return AuthenticationsState(
        stepOne: stepOne ?? this.stepOne,
        stepTwo: stepTwo ?? this.stepTwo,
        stepThree: stepThree ?? this.stepThree,
        frontID: frontID ?? this.frontID,
        backID: backID ?? this.backID,
        isLoading: isLoading ?? this.isLoading,
        face: face ?? this.face,
        dataBackID: dataBackID ?? this.dataBackID,
        dataFrontID: dataFrontID ?? this.dataFrontID);
  }

  @override
  List<Object?> get props => [stepOne, stepTwo, stepThree, frontID, backID, face, isLoading, dataFrontID, dataBackID];
}

class AuthenticationsSuccessState extends AuthenticationsState {
  final String message;

  const AuthenticationsSuccessState({required this.message});
  @override
  List<Object?> get props => [stepOne, stepTwo, stepThree, frontID, backID, face, isLoading, dataFrontID, dataBackID];
}
