part of 'bloc.app.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final AuthEntity authEntity;
  final UserEntity userEntity;
  final bool isFirstTime;
  final bool rememberMe;
  final num role;

  const AppState({
    this.isDarkMode = false,
    this.languageCode = 'en',
    required this.authEntity,
    this.isFirstTime = true,
    this.role = 1,
    this.rememberMe = false,
    required this.userEntity,
  });

  AppState copyWith({
    bool? isDarkMode,
    String? languageCode,
    AuthEntity? authEntity,
    bool? isFirstTime,
    num? role,
    bool? rememberMe,
    UserEntity? userEntity,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      authEntity: authEntity ?? this.authEntity,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      role: role ?? this.role,
      rememberMe: rememberMe ?? this.rememberMe,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json['isDarkMode'],
      languageCode: json['languageCode'],
      authEntity: AuthEntity.fromJson(json['authEntity']),
      isFirstTime: json['isFirstTime'],
      role: json['role'],
      rememberMe: json['rememberMe'],
      userEntity: UserEntity.fromJson(json['userEntity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'authEntity': authEntity,
      'isFirstTime': isFirstTime,
      'role': role,
      'rememberMe': rememberMe,
      'userEntity': userEntity,
    };
  }

  @override
  List<Object?> get props => [
        isDarkMode,
        languageCode,
        isFirstTime,
        authEntity,
        role,
        rememberMe,
        userEntity,
      ];
}
