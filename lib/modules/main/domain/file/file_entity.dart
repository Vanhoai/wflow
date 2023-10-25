import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'file_entity.g.dart';

@JsonSerializable()
class FileEntity extends BaseEntity with EquatableMixin {
  const FileEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.state,
    required this.name,
    required this.content,
    required this.type,
    required this.publicId,
  });

  @JsonKey(name: 'state', defaultValue: '')
  final String state;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'content', defaultValue: '')
  final String content;

  @JsonKey(name: 'type', defaultValue: '')
  final String type;

  @JsonKey(name: 'publicId', defaultValue: '')
  final String publicId;

  factory FileEntity.fromJson(Map<String, dynamic> json) => _$FileEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FileEntityToJson(this);

  FileEntity copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? state,
    String? name,
    String? content,
    String? type,
    String? publicId,
  }) {
    return FileEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      state: state ?? this.state,
      name: name ?? this.name,
      content: content ?? this.content,
      type: type ?? this.type,
      publicId: publicId ?? this.publicId,
    );
  }

  factory FileEntity.createEmpty() {
    return const FileEntity(
      id: 0,
      createdAt: '',
      updatedAt: '',
      deletedAt: '',
      state: '',
      name: '',
      content: '',
      type: '',
      publicId: '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        state,
        name,
        content,
        type,
        publicId,
      ];
}
