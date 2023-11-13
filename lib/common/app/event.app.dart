part of 'bloc.app.dart';

class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppChangeLanguage extends AppEvent {
  final String languageCode;

  AppChangeLanguage({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];
}

class AppChangeTheme extends AppEvent {
  final bool isDarkMode;

  AppChangeTheme({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];
}

class SetIsFirstTime extends AppEvent {}

class AppChangeUser extends AppEvent {
  final UserEntity userEntity;

  AppChangeUser({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class AppChangeAuth extends AppEvent {
  final AuthEntity authEntity;
  final num role;
  final bool rememberMe;

  AppChangeAuth({
    required this.authEntity,
    this.role = 0,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [authEntity, role, rememberMe];
}

class RefreshTokenEvent extends AppEvent {
  final String accessToken;
  final String refreshToken;

  RefreshTokenEvent({required this.accessToken, required this.refreshToken});
}

class ResetAppEvent extends AppEvent {}
