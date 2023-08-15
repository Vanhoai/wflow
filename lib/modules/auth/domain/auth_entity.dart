import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthEntity({required this.accessToken, required this.refreshToken});

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  List<Object?> get props => [];
}
