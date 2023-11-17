import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'feedback_entity.g.dart';

@JsonSerializable()
class FeedbackEntity extends BaseEntity with EquatableMixin {
  final String state;
  final num star;
  final String description;
  final String businessName;
  final String businessLogo;

  FeedbackEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.state,
    required this.star,
    required this.description,
    required this.businessName,
    required this.businessLogo,
  });

  factory FeedbackEntity.fromJson(Map<String, dynamic> json) => _$FeedbackEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FeedbackEntityToJson(this);

  FeedbackEntity copyWith({
    String? state,
    num? star,
    String? description,
    String? businessName,
    String? businessLogo,
  }) {
    return FeedbackEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      state: state ?? this.state,
      star: star ?? this.star,
      description: description ?? this.description,
      businessName: businessName ?? this.businessName,
      businessLogo: businessLogo ?? this.businessLogo,
    );
  }

  factory FeedbackEntity.createEmpty() {
    return FeedbackEntity(
      id: 0,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      state: '',
      star: 0,
      description: '',
      businessName: '',
      businessLogo: '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        state,
        star,
        description,
        businessName,
        businessLogo,
      ];
}
