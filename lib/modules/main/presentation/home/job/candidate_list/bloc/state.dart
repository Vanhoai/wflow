import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/candidate/candidate_entity.dart';

class CandidateListState extends Equatable {
  final bool isLoading;
  final Meta meta;
  final String search;

  const CandidateListState(
      {this.isLoading = false,
      this.meta = const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
      this.search = ''});

  CandidateListState copyWith({bool? isLoading}) {
    return CandidateListState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}

class GetCandidateAppliedListSuccess extends CandidateListState {
  final List<CandidateEntity> candidateEntities;
  final bool loadMore;
  const GetCandidateAppliedListSuccess(
      {required this.candidateEntities,
      required super.meta,
      required super.isLoading,
      required this.loadMore,
      required super.search});

  @override
  GetCandidateAppliedListSuccess copyWith(
      {List<CandidateEntity>? candidateEntities, bool? loadMore, bool? isLoading, Meta? meta, String? search}) {
    return GetCandidateAppliedListSuccess(
        candidateEntities: candidateEntities ?? this.candidateEntities,
        meta: meta ?? super.meta,
        isLoading: isLoading ?? super.isLoading,
        loadMore: loadMore ?? this.loadMore,
        search: search ?? super.search);
  }

  @override
  List<Object?> get props => [candidateEntities, meta, isLoading, loadMore];
}
