part of "bloc.dart";

class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnChangeEmailEvent extends SignInEvent{
  final String email;

  OnChangeEmailEvent({required this.email});
  @override
  List<Object?> get props => [email];
}
class SignInSubmitted extends SignInEvent {
  final String email;
  final String password;

  SignInSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignInWithBiometrics extends SignInEvent {}

class ResetSignInState extends SignInEvent {}
