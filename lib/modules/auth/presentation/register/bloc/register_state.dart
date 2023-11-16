part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();

  @override
  List<Object> get props => [];
}

class RegisterEmailSuccessState extends RegisterState {
  final String message;

  const RegisterEmailSuccessState({required this.message});

  RegisterEmailSuccessState copyWith({
    String? message,
  }) {
    return RegisterEmailSuccessState(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}

class RegisterPhoneSuccessState extends RegisterState {
  final String message;

  const RegisterPhoneSuccessState({required this.message});

  RegisterPhoneSuccessState copyWith({
    String? message,
  }) {
    return RegisterPhoneSuccessState(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}

class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
