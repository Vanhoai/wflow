part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitialEvent extends ChangePasswordEvent {}

final class ChangePasswordSubmitEvent extends ChangePasswordEvent {
  const ChangePasswordSubmitEvent({
    required this.oldPassword,
    required this.newPassword,
  });

  final String oldPassword;
  final String newPassword;

  ChangePasswordSubmitEvent copyWith({
    String? oldPassword,
    String? newPassword,
  }) =>
      ChangePasswordSubmitEvent(
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
      );

  @override
  List<Object> get props => [oldPassword, newPassword];
}

final class ChangePasswordSuccessEvent extends ChangePasswordEvent {
  final String message;
  const ChangePasswordSuccessEvent({required this.message});

  @override
  List<Object> get props => [message];
}

final class ChangePasswordFailureEvent extends ChangePasswordEvent {
  const ChangePasswordFailureEvent({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
