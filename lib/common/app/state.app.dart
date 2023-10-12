part of 'bloc.app.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final AuthEntity authEntity;

  const AppState({
    this.isDarkMode = false,
    this.languageCode = 'en',
    required this.authEntity,
  });

  AppState copyWith({
    bool? isDarkMode,
    String? languageCode,
    AuthEntity? authEntity,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      authEntity: authEntity ?? this.authEntity,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json['isDarkMode'],
      languageCode: json['languageCode'],
      authEntity: AuthEntity.fromJson(json['authEntity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'authEntity': authEntity,
    };
  }

  @override
  List<Object?> get props => [isDarkMode, languageCode];
}
