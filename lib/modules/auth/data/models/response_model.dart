import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/auth/domain/auth_entity.dart';

part 'response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthSignInResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  const AuthSignInResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthSignInResponse.fromJson(Map<String, dynamic> json) => _$AuthSignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignInResponseToJson(this);
}
