import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.entity.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthEntity({required this.accessToken, required this.refreshToken});

  factory AuthEntity.fromJson(Map<String, dynamic> json) => _$AuthEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthEntityToJson(this);

  @override
  List<Object?> get props => [];
}
