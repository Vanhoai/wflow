part of 'app_bloc.dart';

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

class AppChangeLoading extends AppEvent {
  final bool isLoading;

  AppChangeLoading({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}
