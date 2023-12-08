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
    required this.username,
    required this.confirmPassword,
    required this.type,
  });

  final String username;
  final String password;
  final String confirmPassword;
  final String type;

  ResetPasswordSubmitEvent copyWith({
    String? password,
    String? username,
    String? confirmPassword,
    String? type,
  }) =>
      ResetPasswordSubmitEvent(
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        username: username ?? this.username,
        type: type ?? this.type,
      );

  @override
  List<Object> get props => [password, confirmPassword, username, type];
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
