part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

final class ResetPasswordFailure extends ResetPasswordState {
  const ResetPasswordFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
