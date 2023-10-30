import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity extends BaseEntity with EquatableMixin {
  final String state;
  final String title;
  final String content;

  @EpochDateTimeConverter()
  final DateTime startTime;

  @EpochDateTimeConverter()
  final DateTime endTime;

  final num salary;

  TaskEntity({
    required this.state,
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
    required this.salary,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) => _$TaskEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  TaskEntity copyWith({
    String? state,
    String? title,
    String? content,
    DateTime? startTime,
    DateTime? endTime,
    num? salary,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return TaskEntity(
      state: state ?? this.state,
      title: title ?? this.title,
      content: content ?? this.content,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      salary: salary ?? this.salary,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props => [
        state,
        title,
        content,
        startTime,
        endTime,
        salary,
        id,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
