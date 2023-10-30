import 'dart:io';

import 'package:equatable/equatable.dart';

class AuthenticationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepOneEvent extends AuthenticationsEvent {
  final File frontID;

  StepOneEvent({required this.frontID});
  @override
  List<Object?> get props => [frontID];
}

class StepTwoEvent extends AuthenticationsEvent {
  final File backID;

  StepTwoEvent({required this.backID});
  @override
  List<Object?> get props => [backID];
}

class StepThreeEvent extends AuthenticationsEvent {
  final File face;

  StepThreeEvent({required this.face});
  @override
  List<Object?> get props => [face];
}

class FaceMatchEvent extends AuthenticationsEvent {}

class CleanData extends AuthenticationsEvent {}
