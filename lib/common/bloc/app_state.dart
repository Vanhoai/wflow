part of 'app_bloc.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final String languageCode;

  const AppState({
    this.isDarkMode = false,
    this.languageCode = "en",
  });

  AppState copyWith({
    bool? isDarkMode,
    String? languageCode,
    bool? enableSignIn,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, languageCode];
}
