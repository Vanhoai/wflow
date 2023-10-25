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

class AppChangeAuth extends AppEvent {
  final AuthEntity authEntity;
  final num role;

  AppChangeAuth({required this.authEntity, this.role = 0});

  @override
  List<Object?> get props => [authEntity, role];
}

class RefreshTokenEvent extends AppEvent {
  final String accessToken;
  final String refreshToken;

  RefreshTokenEvent({required this.accessToken, required this.refreshToken});
}
