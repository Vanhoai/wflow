import 'package:equatable/equatable.dart';

class CandidateListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCandidateAppliedListEvent extends CandidateListEvent {
  final num post;

  GetCandidateAppliedListEvent({required this.post});
  @override
  List<Object?> get props => [post];
}

class GetCandidateAppliedListMoreEvent extends CandidateListEvent {
  final num post;

  GetCandidateAppliedListMoreEvent({required this.post});
  @override
  List<Object?> get props => [post];
}

class GetCandidateAppliedSearchEvent extends CandidateListEvent {
  final num post;
  final String search;

  GetCandidateAppliedSearchEvent({required this.post, required this.search});
  @override
  List<Object?> get props => [post, search];
}
