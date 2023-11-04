part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterTypeEvent extends RegisterEvent {
  final String username;
  final String password;
  final String type;
  const RegisterTypeEvent({required this.username, required this.password, required this.type});

  @override
  List<Object> get props => [username, password, type];
}

class RegisterErrorEvent extends RegisterEvent {
  final String message;
  const RegisterErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}
