import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool regex;
  final bool isRemember;

  const SignInState({this.email = '', this.password = '', this.regex = false, this.isRemember = false});

  SignInState copyWith({String? email, String? password, bool? regex, bool? isRemember}) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      regex: regex ?? this.regex,
      isRemember: isRemember ?? this.isRemember,
    );
  }

  @override
  List<Object?> get props => [email, password, regex, isRemember];
}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String message;

  const SignInFailure({this.message = ''});
}
