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

class ChangeEmailEvent extends SignInEvent {
  final String email;

  ChangeEmailEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ChangePasswordEvent extends SignInEvent {
  final String password;

  ChangePasswordEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class SignInSearchingEvent extends SignInEvent {
  final String search;

  SignInSearchingEvent({required this.search});

  @override
  List<Object?> get props => [search];
}
