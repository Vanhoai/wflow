import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'tracking_entity.g.dart';

@JsonSerializable()
class TrackingEntity extends BaseEntity with EquatableMixin {
  final String state;
  final String action;
  final int amount;

  TrackingEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.state,
    required this.action,
    required this.amount,
  });

  factory TrackingEntity.fromJson(Map<String, dynamic> json) => _$TrackingEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TrackingEntityToJson(this);

  TrackingEntity copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? state,
    String? action,
    int? amount,
  }) {
    return TrackingEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      state: state ?? this.state,
      action: action ?? this.action,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [
        super.id,
        super.createdAt,
        super.updatedAt,
        super.deletedAt,
        state,
        action,
        amount,
      ];
}
