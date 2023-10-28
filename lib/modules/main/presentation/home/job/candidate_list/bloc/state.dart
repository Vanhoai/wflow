import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/contract/contract_entity.dart';

class CandidateListState extends Equatable {
  final bool isLoading;
  final Meta meta;
  final String search;
  final num post;

  const CandidateListState(
      {this.isLoading = false,
      this.meta = const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
      this.search = '',
      this.post = 0});

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
      required super.search,
      required super.post});

  @override
  GetCandidateAppliedListSuccess copyWith(
      {List<CandidateEntity>? candidateEntities,
      bool? loadMore,
      bool? isLoading,
      Meta? meta,
      String? search,
      num? post}) {
    return GetCandidateAppliedListSuccess(
        candidateEntities: candidateEntities ?? this.candidateEntities,
        meta: meta ?? super.meta,
        isLoading: isLoading ?? super.isLoading,
        loadMore: loadMore ?? this.loadMore,
        search: search ?? super.search,
        post: post ?? super.post);
  }

  @override
  List<Object?> get props => [candidateEntities, meta, isLoading, loadMore, post];
}
