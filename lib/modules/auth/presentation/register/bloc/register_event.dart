part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterTypeEvent extends RegisterEvent {
  final String username;
  final String password;
  final String type;
  RegisterTypeEvent({required this.username, required this.password, required this.type});
}

class RegisterErrorEvent extends RegisterEvent {
  final String message;
  RegisterErrorEvent({required this.message});
}

class RegisterWithGoogleEvent extends RegisterEvent {}
