import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final bool isSignIn;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.isSignIn,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => _$AuthEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthEntityToJson(this);

  AuthEntity copyWith({
    String? accessToken,
    String? refreshToken,
    bool? isSignIn,
  }) {
    return AuthEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isSignIn: isSignIn ?? this.isSignIn,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, isSignIn];
}
