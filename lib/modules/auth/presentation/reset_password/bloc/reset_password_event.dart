part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitEvent extends ResetPasswordEvent {
  const ResetPasswordInitEvent();
}

final class ResetPasswordSubmitEvent extends ResetPasswordEvent {
  const ResetPasswordSubmitEvent({
    required this.password,
    required this.confirmPassword,
  });

  final String password;
  final String confirmPassword;

  ResetPasswordSubmitEvent copyWith({
    String? password,
    String? confirmPassword,
  }) =>
      ResetPasswordSubmitEvent(
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );

  @override
  List<Object> get props => [password, confirmPassword];
}

final class ResetPasswordSuccessEvent extends ResetPasswordEvent {
  final String message;
  const ResetPasswordSuccessEvent({required this.message});

  @override
  List<Object> get props => [message];
}

final class ResetPasswordFailureEvent extends ResetPasswordEvent {
  const ResetPasswordFailureEvent({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
