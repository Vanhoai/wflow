part of 'verification_bloc.dart';

class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationPhoneInitEvent extends VerificationEvent {
  final String phoneNumber;

  const VerificationPhoneInitEvent({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class VerificationPhoneStartEvent extends VerificationEvent {
  final String otpNumber;
  final String verification;

  const VerificationPhoneStartEvent({required this.otpNumber, required this.verification});

  VerificationPhoneStartEvent copyWith(
    String? otpNumber,
    String? verification,
  ) {
    return VerificationPhoneStartEvent(
      otpNumber: otpNumber ?? this.otpNumber,
      verification: verification ?? this.verification,
    );
  }

  @override
  List<Object> get props => [otpNumber, verification];
}

class VerificationEmailInitEvent extends VerificationEvent {
  final String email;

  const VerificationEmailInitEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class VerificationEmailStartEvent extends VerificationEvent {
  final String otpNumber;
  final String verification;

  const VerificationEmailStartEvent({required this.otpNumber, required this.verification});

  VerificationEmailStartEvent copyWith(
    String? otpNumber,
    String? verification,
  ) {
    return VerificationEmailStartEvent(
      otpNumber: otpNumber ?? this.otpNumber,
      verification: verification ?? this.verification,
    );
  }

  @override
  List<Object> get props => [otpNumber, verification];
}
