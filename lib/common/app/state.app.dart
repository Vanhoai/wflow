part of 'bloc.app.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final AuthEntity authEntity;
  final bool isFirstTime;

  const AppState({
    this.isDarkMode = false,
    this.languageCode = 'en',
    required this.authEntity,
    this.isFirstTime = true
  });

  AppState copyWith({
    bool? isDarkMode,
    String? languageCode,
    AuthEntity? authEntity,
    bool? isFirstTime,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      authEntity: authEntity ?? this.authEntity,
      isFirstTime: isFirstTime ?? this.isFirstTime
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json['isDarkMode'],
      languageCode: json['languageCode'],
      authEntity: AuthEntity.fromJson(json['authEntity']),
      isFirstTime: json['isFirstTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'authEntity': authEntity,
      'isFirstTime': isFirstTime,
    };
  }

  @override
  List<Object?> get props => [isDarkMode, languageCode,isFirstTime];
}
