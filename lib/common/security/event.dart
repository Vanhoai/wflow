part of 'bloc.dart';

class SecurityEvent extends Equatable {
  const SecurityEvent();

  @override
  List<Object> get props => [];
}

class ToggleTouchIDEvent extends SecurityEvent {
  final bool touchIDEnabled;

  const ToggleTouchIDEvent({required this.touchIDEnabled});

  @override
  List<Object> get props => [touchIDEnabled];
}

class ToggleFaceIDEvent extends SecurityEvent {
  final bool faceIDEnabled;

  const ToggleFaceIDEvent({required this.faceIDEnabled});

  @override
  List<Object> get props => [faceIDEnabled];
}

class SaveCredentialsEvent extends SecurityEvent {
  final String email;
  final String password;

  const SaveCredentialsEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginWithTouchIDEvent extends SecurityEvent {
  const LoginWithTouchIDEvent();

  @override
  List<Object> get props => [];
}

class LoginWithFaceIDEvent extends SecurityEvent {
  const LoginWithFaceIDEvent();

  @override
  List<Object> get props => [];
}

class ClearAllDataEvent extends SecurityEvent {
  const ClearAllDataEvent();

  @override
  List<Object> get props => [];
}

class RememberMeEvent extends SecurityEvent {
  final bool rememberMe;

  const RememberMeEvent({required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];
}
