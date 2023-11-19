part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  const ChangePasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class ChangePasswordFailure extends ChangePasswordState {
  final String message;

  const ChangePasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}
