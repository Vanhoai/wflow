import 'package:json_annotation/json_annotation.dart';

part 'base_entity.g.dart';

@JsonSerializable()
class BaseEntity {
  @JsonKey(name: 'id', required: true)
  final int id;

  @EpochDateTimeConverter()
  final String createdAt;

  @EpochDateTimeConverter()
  final String updatedAt;

  @EpochDateTimeConverter()
  final String? deletedAt;

  const BaseEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory BaseEntity.fromJson(Map<String, dynamic> json) => _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);
}

class EpochDateTimeConverter implements JsonConverter<dynamic, dynamic> {
  const EpochDateTimeConverter();

  @override
  dynamic fromJson(dynamic json) {
    if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }
    return json;
  }

  @override
  dynamic toJson(dynamic object) {
    if (object is DateTime) {
      return object.millisecondsSinceEpoch;
    }
    return object;
  }
}
