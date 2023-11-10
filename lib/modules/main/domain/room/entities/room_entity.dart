import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

part 'room_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomEntity extends BaseEntity with EquatableMixin {
  @JsonKey(name: 'state', defaultValue: '')
  final String state;
  final UserEntity userCreator;
  final UserEntity userClient;
  @JsonKey(name: 'messages', defaultValue: [])
  final List<MessagesEntity> messages;

  RoomEntity({
    required this.state,
    required this.userCreator,
    required this.userClient,
    required this.messages,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
  });

  factory RoomEntity.fromJson(Map<String, dynamic> json) => _$RoomEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoomEntityToJson(this);

  RoomEntity copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? state,
    UserEntity? userCreator,
    UserEntity? userClient,
    List<MessagesEntity>? messages,
  }) {
    return RoomEntity(
      state: state ?? this.state,
      userCreator: userCreator ?? this.userCreator,
      userClient: userClient ?? this.userClient,
      messages: messages ?? this.messages,
      id: id ?? super.id,
      createdAt: createdAt ?? super.createdAt,
      updatedAt: updatedAt ?? super.updatedAt,
      deletedAt: deletedAt ?? super.deletedAt,
    );
  }

  @override
  List<Object?> get props => [state, userCreator, userClient, messages, createdAt, updatedAt, deletedAt, id];
}

@JsonSerializable()
class MessagesEntity extends BaseEntity with EquatableMixin {
  final String message;
  final String type;
  final UserEntity userSender;
  MessagesEntity({
    required this.message,
    required this.type,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.userSender,
  });

  factory MessagesEntity.fromJson(Map<String, dynamic> json) => _$MessagesEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessagesEntityToJson(this);

  MessagesEntity copyWith(
      {int? id,
      String? message,
      String? type,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      UserEntity? userSender}) {
    return MessagesEntity(
      message: message ?? this.message,
      type: type ?? this.type,
      id: id ?? super.id,
      createdAt: createdAt ?? super.createdAt,
      updatedAt: updatedAt ?? super.updatedAt,
      deletedAt: deletedAt ?? super.deletedAt,
      userSender: userSender ?? this.userSender,
    );
  }

  @override
  List<Object?> get props => [message, type, createdAt, updatedAt, deletedAt, id, userSender];
}
