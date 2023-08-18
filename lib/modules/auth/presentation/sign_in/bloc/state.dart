part of "bloc.dart";

class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final Failure failure;

  SignInFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
