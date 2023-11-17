part of 'reputation_bloc.dart';

class ReputationState extends Equatable {
  final ReputationEntity reputationEntity;
  final List<FeedbackEntity> feedbacks;

  const ReputationState({
    required this.reputationEntity,
    required this.feedbacks,
  });

  ReputationState copyWith({
    ReputationEntity? reputationEntity,
    List<FeedbackEntity>? feedbacks,
  }) {
    return ReputationState(
      reputationEntity: reputationEntity ?? this.reputationEntity,
      feedbacks: feedbacks ?? this.feedbacks,
    );
  }

  @override
  List<Object> get props => [reputationEntity, feedbacks];
}
