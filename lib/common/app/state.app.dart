part of 'bloc.app.dart';

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

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json["isDarkMode"],
      languageCode: json["languageCode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isDarkMode": isDarkMode,
      "languageCode": languageCode,
    };
  }

  @override
  List<Object?> get props => [isDarkMode, languageCode];
}
