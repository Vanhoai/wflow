part of "bloc.dart";

class SignInState extends Equatable {
  final SignInData data;
  final String search;

  const SignInState({
    this.data = const SignInData(email: "", password: ""),
    this.search = "",
  });

  SignInState copyWith({
    SignInData? data,
    String? search,
  }) {
    return SignInState(
      data: data ?? this.data,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [];
}

class SignInData extends Equatable {
  final String email;
  final String password;

  const SignInData({
    required this.email,
    required this.password,
  });

  SignInData copyWith({
    String? email,
    String? password,
  }) {
    return SignInData(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [email, password];
}

class SignInBuilder {
  final SignInState state;

  SignInBuilder({required this.state});

  SignInBuilder data({
    String? email,
    String? password,
  }) {
    return SignInBuilder(
      state: state.copyWith(
        data: state.data.copyWith(
          email: email ?? state.data.email,
          password: password ?? state.data.password,
        ),
      ),
    );
  }

  SignInBuilder search(String search) {
    return SignInBuilder(
      state: state.copyWith(
        search: search,
      ),
    );
  }

  SignInState build() {
    return state;
  }
}
