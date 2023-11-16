import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'report_entity.g.dart';

@JsonSerializable()
class ReportEntity extends BaseEntity with EquatableMixin {
  final String content;
  final String state;
  final num target;
  final String type;

  ReportEntity({
    required this.content,
    required this.state,
    required this.target,
    required this.type,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
  });
  factory ReportEntity.fromJson(Map<String, dynamic> json) => _$ReportEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportEntityToJson(this);

  ReportEntity copyWith(
      {int? id,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      String? state,
      num? target,
      String? content,
      String? type}) {
    return ReportEntity(
      state: state ?? this.state,
      content: content ?? this.content,
      target: target ?? this.target,
      type: type ?? this.type,
      id: id ?? super.id,
      createdAt: createdAt ?? super.createdAt,
      updatedAt: updatedAt ?? super.updatedAt,
      deletedAt: deletedAt ?? super.deletedAt,
    );
  }

  @override
  List<Object?> get props => [state, content, target, type, createdAt, updatedAt, deletedAt, id];
}
