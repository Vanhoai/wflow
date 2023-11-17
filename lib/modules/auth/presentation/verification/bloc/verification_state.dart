part of 'verification_bloc.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

final class VerificationPhoneRegisterSuccessState extends VerificationState {
  final String username;
  final String password;
  final String message;
  final String type = 'phone';

  const VerificationPhoneRegisterSuccessState({
    required this.message,
    required this.username,
    required this.password,
  });

  VerificationPhoneRegisterSuccessState copyWith({String? message, String? username, String? password}) {
    return VerificationPhoneRegisterSuccessState(
      message: message ?? this.message,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [message, username, password, type];
}

final class VerificationPhoneRegisterFailureState extends VerificationState {
  final String message;

  const VerificationPhoneRegisterFailureState({
    required this.message,
  });

  VerificationPhoneRegisterFailureState copyWith({String? message}) {
    return VerificationPhoneRegisterFailureState(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}

final class VerificationEmailRegisterSuccessState extends VerificationState {
  final String username;
  final String password;
  final String message;
  final String type = 'email';

  const VerificationEmailRegisterSuccessState({
    required this.message,
    required this.username,
    required this.password,
  });

  VerificationEmailRegisterSuccessState copyWith({
    String? message,
    String? username,
    String? password,
  }) {
    return VerificationEmailRegisterSuccessState(
      message: message ?? this.message,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [message, username, password, type];
}

final class VerificationEmailRegisterFailureState extends VerificationState {
  final String message;

  const VerificationEmailRegisterFailureState({
    required this.message,
  });

  VerificationEmailRegisterFailureState copyWith({String? message}) {
    return VerificationEmailRegisterFailureState(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}

final class VerificationPhoneForgotPasswordSuccessState extends VerificationState {
  final String message;
  final String phoneNumber;

  const VerificationPhoneForgotPasswordSuccessState({
    required this.message,
    required this.phoneNumber,
  });

  VerificationPhoneForgotPasswordSuccessState copyWith({String? message, String? phoneNumber}) {
    return VerificationPhoneForgotPasswordSuccessState(
      message: message ?? this.message,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object> get props => [message, phoneNumber];
}

final class VerificationPhoneForgotPasswordFailureState extends VerificationState {
  final String message;

  const VerificationPhoneForgotPasswordFailureState({
    required this.message,
  });

  VerificationPhoneForgotPasswordFailureState copyWith({String? message}) {
    return VerificationPhoneForgotPasswordFailureState(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}

final class VerificationEmailForgotSuccessPasswordState extends VerificationState {
  final String email;
  final String message;

  const VerificationEmailForgotSuccessPasswordState({
    required this.message,
    required this.email,
  });

  VerificationEmailForgotSuccessPasswordState copyWith({String? message, String? email}) {
    return VerificationEmailForgotSuccessPasswordState(
      message: message ?? this.message,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [message, email];
}

final class VerificationEmailForgotFailurePasswordState extends VerificationState {
  final String message;

  const VerificationEmailForgotFailurePasswordState({
    required this.message,
  });

  VerificationEmailForgotFailurePasswordState copyWith({String? message}) {
    return VerificationEmailForgotFailurePasswordState(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}
