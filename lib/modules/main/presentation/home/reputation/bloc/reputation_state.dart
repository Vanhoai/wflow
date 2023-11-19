part of 'reputation_bloc.dart';

class ReputationState extends Equatable {
  final ReputationEntity reputationEntity;
  final List<FeedbackEntity> feedbacks;
  final bool isLoading;

  const ReputationState({
    required this.reputationEntity,
    required this.feedbacks,
    this.isLoading = false,
  });

  ReputationState copyWith({
    ReputationEntity? reputationEntity,
    List<FeedbackEntity>? feedbacks,
    bool? isLoading,
  }) {
    return ReputationState(
      reputationEntity: reputationEntity ?? this.reputationEntity,
      feedbacks: feedbacks ?? this.feedbacks,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [reputationEntity, feedbacks, isLoading];
}
