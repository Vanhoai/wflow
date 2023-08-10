part of 'app_bloc.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final bool isLoading;

  const AppState({
    this.isDarkMode = false,
    this.languageCode = "en",
    this.isLoading = false,
  });

  AppState copyWith({
    bool? isDarkMode,
    String? languageCode,
    bool? isLoading,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, languageCode, isLoading];
}
