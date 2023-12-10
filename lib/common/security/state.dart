part of 'bloc.dart';

class SecurityState extends Equatable {
  final bool touchIDEnabled;
  final bool isRememberMe;

  const SecurityState({
    required this.touchIDEnabled,
    required this.isRememberMe,
  });

  factory SecurityState.fromJson(Map<String, dynamic> json) {
    return SecurityState(
      touchIDEnabled: json['touchIDEnabled'],
      isRememberMe: json['isRememberMe'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'touchIDEnabled': touchIDEnabled,
      'isRememberMe': isRememberMe,
    };
  }

  SecurityState copyWith({
    bool? touchIDEnabled,
    bool? isRememberMe,
  }) {
    return SecurityState(
      touchIDEnabled: touchIDEnabled ?? this.touchIDEnabled,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }

  @override
  List<Object> get props => [touchIDEnabled, isRememberMe];
}

class BiometricSuccess extends SecurityState {
  final String email;
  final String password;

  const BiometricSuccess({
    required this.email,
    required this.password,
  }) : super(touchIDEnabled: true, isRememberMe: true);

  @override
  List<Object> get props => [email, password, touchIDEnabled, isRememberMe];
}
