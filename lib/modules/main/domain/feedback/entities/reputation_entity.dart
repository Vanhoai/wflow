import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reputation_entity.g.dart';

@JsonSerializable()
class ReputationEntity with EquatableMixin {
  @JsonKey(name: 'reputation')
  final double reputation;

  @JsonKey(name: 'totalFeedback')
  final int totalFeedback;

  @JsonKey(name: 'countStarOne')
  final int countStarOne;

  @JsonKey(name: 'countStarTwo')
  final int countStarTwo;

  @JsonKey(name: 'countStarThree')
  final int countStarThree;

  @JsonKey(name: 'countStarFour')
  final int countStarFour;

  @JsonKey(name: 'countStarFive')
  final int countStarFive;

  ReputationEntity({
    required this.reputation,
    required this.totalFeedback,
    required this.countStarOne,
    required this.countStarTwo,
    required this.countStarThree,
    required this.countStarFour,
    required this.countStarFive,
  });

  factory ReputationEntity.fromJson(Map<String, dynamic> json) => _$ReputationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReputationEntityToJson(this);

  ReputationEntity copyWith({
    double? reputation,
    int? totalFeedback,
    int? countStarOne,
    int? countStarTwo,
    int? countStarThree,
    int? countStarFour,
    int? countStarFive,
  }) {
    return ReputationEntity(
      reputation: reputation ?? this.reputation,
      totalFeedback: totalFeedback ?? this.totalFeedback,
      countStarOne: countStarOne ?? this.countStarOne,
      countStarTwo: countStarTwo ?? this.countStarTwo,
      countStarThree: countStarThree ?? this.countStarThree,
      countStarFour: countStarFour ?? this.countStarFour,
      countStarFive: countStarFive ?? this.countStarFive,
    );
  }

  factory ReputationEntity.createEmpty() {
    return ReputationEntity(
      reputation: 0,
      totalFeedback: 0,
      countStarOne: 0,
      countStarTwo: 0,
      countStarThree: 0,
      countStarFour: 0,
      countStarFive: 0,
    );
  }

  @override
  List<Object?> get props => [
        reputation,
        totalFeedback,
        countStarOne,
        countStarTwo,
        countStarThree,
        countStarFour,
        countStarFive,
      ];
}
