part of 'verification_bloc.dart';

class VerificationState extends Equatable {
  final String username;
  final String password;
  final String type;
  final bool isSuccess;
  final bool isError;
  final String message;

  const VerificationState({
    required this.username,
    required this.password,
    required this.type,
    this.isSuccess = false,
    this.isError = false,
    this.message = '',
  });

  VerificationState copyWith({
    String? username,
    String? password,
    String? type,
    bool? isSuccess,
    bool? isError,
    String? message,
  }) {
    return VerificationState(
      username: username ?? this.username,
      password: password ?? this.password,
      type: type ?? this.type,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        username,
        password,
        type,
        isSuccess,
        isError,
        message,
      ];
}

final class VerificationInitial extends VerificationState {
  const VerificationInitial()
      : super(
          username: '',
          password: '',
          type: '',
          isSuccess: false,
          isError: false,
          message: '',
        );
}
