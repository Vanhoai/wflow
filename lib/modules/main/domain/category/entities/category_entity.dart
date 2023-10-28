import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity extends Equatable {
  final num id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String type;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  CategoryEntity copyWith({
    num? id,
    String? name,
    String? createdAt,
    String? updatedAt,
    String? type,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt, type];
}
