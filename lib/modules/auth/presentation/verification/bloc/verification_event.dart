part of 'verification_bloc.dart';

sealed class VerificationEvent extends Equatable {
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
