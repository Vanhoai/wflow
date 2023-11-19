part of 'verification_bloc.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

final class VerificationInitialEvent extends VerificationEvent {}

final class VerificationEmailInitEvent extends VerificationEvent {
  final String email;
  final String otpCode;

  const VerificationEmailInitEvent({
    required this.email,
    required this.otpCode,
  });

  @override
  List<Object> get props => [email, otpCode];
}

final class VerificationEmailResetInitEvent extends VerificationEvent {
  final String email;
  final String otpCode;

  const VerificationEmailResetInitEvent({
    required this.email,
    required this.otpCode,
  });

  @override
  List<Object> get props => [email, otpCode];
}

final class VerificationPhoneRegisterEvent extends VerificationEvent {
  final String username;
  final String password;
  final String verificationId;
  final String smsCode;

  const VerificationPhoneRegisterEvent({
    required this.username,
    required this.password,
    required this.verificationId,
    required this.smsCode,
  });

  @override
  List<Object> get props => [username, password, verificationId, smsCode];
}

final class VerificationEmailRegisterEvent extends VerificationEvent {
  final String username;
  final String password;
  final String otpCode;

  const VerificationEmailRegisterEvent({
    required this.username,
    required this.otpCode,
    required this.password,
  });

  @override
  List<Object> get props => [username, otpCode, password];
}

final class VerificationPhoneForgotPasswordEvent extends VerificationEvent {
  final String verificationId;
  final String otpCode;

  const VerificationPhoneForgotPasswordEvent({
    required this.verificationId,
    required this.otpCode,
  });

  @override
  List<Object> get props => [verificationId, otpCode];
}

final class VerificationEmailForgotPasswordEvent extends VerificationEvent {
  final String email;
  final String otpCode;

  const VerificationEmailForgotPasswordEvent({
    required this.email,
    required this.otpCode,
  });

  @override
  List<Object> get props => [email, otpCode];
}
