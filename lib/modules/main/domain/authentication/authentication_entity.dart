import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_entity.g.dart';

class AuthenticationEntity<T> extends Equatable {
  final num errorCode;
  final String errorMessage;
  final List<T> data;

  const AuthenticationEntity({required this.errorCode, required this.errorMessage, required this.data});

  factory AuthenticationEntity.fromJson(Map<String, dynamic> json) {
    return AuthenticationEntity(
        errorCode: json['errorCode'], errorMessage: json['errorMessage'], data: json['data'] as List<T>);
  }
  @override
  List<Object?> get props => [errorCode, errorMessage, data];
}

@JsonSerializable()
class FrontID extends Equatable {
  final String id;
  final String name;
  final String dob;
  final String overall_score;
  final String type;

  const FrontID(
      {required this.id, required this.name, required this.dob, required this.overall_score, required this.type});

  factory FrontID.fromJson(Map<String, dynamic> json) => _$FrontIDFromJson(json);

  Map<String, dynamic> toJson() => _$FrontIDToJson(this);

  @override
  List<Object?> get props => [id, name, dob, overall_score, type];
}

@JsonSerializable()
class BackID extends Equatable {
  final String type;

  const BackID({required this.type});

  factory BackID.fromJson(Map<String, dynamic> json) => _$BackIDFromJson(json);

  Map<String, dynamic> toJson() => _$BackIDToJson(this);
  @override
  List<Object?> get props => [type];
}
