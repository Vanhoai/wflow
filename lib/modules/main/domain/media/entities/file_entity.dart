import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'file_entity.g.dart';

@JsonSerializable()
class FileEntity extends BaseEntity with EquatableMixin {
  final String publicId;
  final String content;
  final String type;
  final String? name;
  final String state;

  FileEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.publicId,
    required this.content,
    required this.type,
    required this.name,
    required this.state,
  });

  factory FileEntity.fromJson(Map<String, dynamic> json) => _$FileEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FileEntityToJson(this);

  FileEntity copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? publicId,
    String? content,
    String? type,
    String? name,
    String? state,
  }) {
    return FileEntity(
      id: id ?? super.id,
      createdAt: createdAt ?? super.createdAt,
      updatedAt: updatedAt ?? super.updatedAt,
      deletedAt: deletedAt ?? super.deletedAt,
      publicId: publicId ?? this.publicId,
      content: content ?? this.content,
      type: type ?? this.type,
      name: name ?? this.name,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props =>
      [super.id, super.createdAt, super.updatedAt, super.deletedAt, publicId, content, type, name, state];
}
