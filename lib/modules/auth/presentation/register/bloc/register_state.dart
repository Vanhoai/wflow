part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String type;
  final String username;
  final String password;

  const RegisterState({
    required this.type,
    required this.username,
    required this.password,
  });

  RegisterState copyWith({String? type, String? username, String? password}) {
    return RegisterState(
        type: type ?? this.type, username: username ?? this.username, password: password ?? this.password);
  }

  factory RegisterState.createEmpty() {
    return const RegisterState(type: 'email', username: '', password: '');
  }

  @override
  List<Object> get props => [type, username, password];
}

class RegisterEmailSuccessState extends RegisterState {
  final String message;

  const RegisterEmailSuccessState({required this.message}) : super(type: 'email', username: '', password: '');

  @override
  List<Object> get props => [message];
}

class RegisterPhoneSuccessState extends RegisterState {
  final String message;

  const RegisterPhoneSuccessState({required this.message}) : super(type: 'phone', username: '', password: '');

  @override
  List<Object> get props => [message];
}

class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState({required this.message}) : super(type: 'email', username: '', password: '');

  @override
  List<Object> get props => [message];
}
