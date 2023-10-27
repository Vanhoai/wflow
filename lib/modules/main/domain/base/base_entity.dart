import 'package:json_annotation/json_annotation.dart';

part 'base_entity.g.dart';

@JsonSerializable()
class BaseEntity {
  @JsonKey(name: 'id', required: true)
  final int id;

  @EpochDateTimeConverter()
  final DateTime? createdAt;

  @EpochDateTimeConverter()
  final DateTime? updatedAt;

  @EpochDateTimeConverter()
  final DateTime? deletedAt;

  const BaseEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory BaseEntity.fromJson(Map<String, dynamic> json) => _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);
}

class EpochDateTimeConverter implements JsonConverter<DateTime, String> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.fromMillisecondsSinceEpoch(int.tryParse(json) ?? 0);

  @override
  String toJson(DateTime object) => object.millisecondsSinceEpoch.toString();
}
