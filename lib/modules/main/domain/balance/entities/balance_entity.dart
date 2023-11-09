import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'balance_entity.g.dart';

@JsonSerializable()
class BalanceEntity extends BaseEntity with EquatableMixin {
  final String state;
  final num amount;
  final String customerID;

  BalanceEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.state,
    required this.amount,
    required this.customerID,
  });

  factory BalanceEntity.fromJson(Map<String, dynamic> json) => _$BalanceEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BalanceEntityToJson(this);

  BalanceEntity copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? state,
    int? amount,
    String? customerID,
  }) {
    return BalanceEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      state: state ?? this.state,
      amount: amount ?? this.amount,
      customerID: customerID ?? this.customerID,
    );
  }

  factory BalanceEntity.empty() => BalanceEntity(
        id: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        deletedAt: DateTime.now(),
        state: '',
        amount: 0,
        customerID: '',
      );

  @override
  List<Object?> get props => [id, state, amount, customerID];
}
