import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnChangeEmailEvent extends SignInEvent {
  final String email;

  OnChangeEmailEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class OnChangePasswordEvent extends SignInEvent {
  final String password;

  OnChangePasswordEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

class SignInSubmittedEvent extends SignInEvent {
  final String email;
  final String password;
  final bool isRemember;

  SignInSubmittedEvent({required this.email, required this.password, required this.isRemember});

  @override
  List<Object?> get props => [email, password, isRemember];
}

class RememberPassEvent extends SignInEvent {
  final bool isRemember;

  RememberPassEvent({required this.isRemember});
  @override
  List<Object?> get props => [isRemember];
}

class SignInCheckRememberEvent extends SignInEvent {}

class SignInWithBiometrics extends SignInEvent {}

class ResetSignInState extends SignInEvent {}

class SignInWithGoogleEvent extends SignInEvent {}

class SignInInitialEvent extends SignInEvent {}
