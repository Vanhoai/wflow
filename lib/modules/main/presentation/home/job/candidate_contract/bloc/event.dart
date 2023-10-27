import 'package:equatable/equatable.dart';

class CandidateDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCandidateDetailEvent extends CandidateDetailEvent {
  final String id;

  GetCandidateDetailEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
