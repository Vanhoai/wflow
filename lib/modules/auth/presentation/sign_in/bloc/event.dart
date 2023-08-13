part of "bloc.dart";

class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInSubmitEvent extends SignInEvent {
  final String email;
  final String password;

  SignInSubmitEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RedirectEvent extends SignInEvent {}
