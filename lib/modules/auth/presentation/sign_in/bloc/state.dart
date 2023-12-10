import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool regex;

  const SignInState({this.email = '', this.password = '', this.regex = false});

  SignInState copyWith({
    String? email,
    String? password,
    bool? regex,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      regex: regex ?? this.regex,
    );
  }

  @override
  List<Object?> get props => [email, password, regex];
}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String message;

  const SignInFailure({this.message = ''});
}
