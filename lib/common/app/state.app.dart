part of 'bloc.app.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final AuthEntity authEntity;
  final bool isFirstTime;
  final num role;

  const AppState({
    this.isDarkMode = false,
    this.languageCode = 'en',
    required this.authEntity,
    this.isFirstTime = true,
    this.role = 1,
  });

  AppState copyWith({
    bool? isDarkMode,
    String? languageCode,
    AuthEntity? authEntity,
    bool? isFirstTime,
    num? role,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      authEntity: authEntity ?? this.authEntity,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      role: role ?? this.role,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json['isDarkMode'],
      languageCode: json['languageCode'],
      authEntity: AuthEntity.fromJson(json['authEntity']),
      isFirstTime: json['isFirstTime'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'authEntity': authEntity,
      'isFirstTime': isFirstTime,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [isDarkMode, languageCode, isFirstTime, authEntity, role];
}
