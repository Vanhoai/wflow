part of "bloc.dart";

class SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final Failure failure;

  SignInFailure({required this.failure});
}
