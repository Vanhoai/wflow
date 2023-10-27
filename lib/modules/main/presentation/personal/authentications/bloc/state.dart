import 'dart:io';

import 'package:equatable/equatable.dart';

class AuthenticationsState extends Equatable {
  final bool stepOne;
  final bool stepTwo;
  final bool stepThree;
  final File? fontID;
  final File? backID;
  final File? face;
  const AuthenticationsState({
    this.stepOne = false,
    this.stepTwo = false,
    this.stepThree = false,
    this.fontID,
    this.backID,
    this.face,
  });
  AuthenticationsState copyWith({
    bool? stepOne,
    bool? stepTwo,
    bool? stepThree,
    File? fontID,
    File? backID,
    File? face,
  }) {
    return AuthenticationsState(
        stepOne: stepOne ?? this.stepOne,
        stepTwo: stepTwo ?? this.stepTwo,
        stepThree: stepThree ?? this.stepThree,
        fontID: fontID ?? this.fontID,
        backID: backID ?? this.backID,
        face: face ?? this.face);
  }

  @override
  List<Object?> get props => [stepOne, stepTwo, stepThree, fontID, backID, face];
}
