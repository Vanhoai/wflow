import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends BaseEntity with EquatableMixin {
  @JsonKey(name: 'state', defaultValue: '')
  final String state;

  @JsonKey(name: 'title', defaultValue: '')
  final String title;

  @JsonKey(name: 'body', defaultValue: '')
  final String body;

  @JsonKey(name: 'receiver', defaultValue: 0)
  final int receiver;

  const NotificationModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.state,
    required this.title,
    required this.body,
    required this.receiver,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [id, createdAt, updatedAt, deletedAt, state, title, body, receiver];
}
