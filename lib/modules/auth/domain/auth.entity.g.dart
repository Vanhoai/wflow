// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthEntity _$AuthEntityFromJson(Map<String, dynamic> json) => AuthEntity(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AuthEntityToJson(AuthEntity instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
