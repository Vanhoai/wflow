part of 'reputation_bloc.dart';

sealed class ReputationEvent extends Equatable {
  const ReputationEvent();

  @override
  List<Object> get props => [];
}

class ReputationInitial extends ReputationEvent {}

class ReputationLoad extends ReputationEvent {}

class FeedbackLoad extends ReputationEvent {}
