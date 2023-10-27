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
  GetCandidateAppliedListMoreEvent();
  @override
  List<Object?> get props => [];
}

class GetCandidateAppliedSearchEvent extends CandidateListEvent {
  final String search;

  GetCandidateAppliedSearchEvent({required this.search});
  @override
  List<Object?> get props => [search];
}
