part of "bloc.dart";

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
