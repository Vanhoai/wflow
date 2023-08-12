part of "bloc.dart";

class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInSubmit extends SignInState {
  final String email;
  final String password;

  SignInSubmit({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
