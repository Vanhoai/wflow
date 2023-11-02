import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/bloc/state.dart';

class CandidateListBloc extends Bloc<CandidateListEvent, CandidateListState> {
  final ContractUseCase contractUseCase;
  CandidateListBloc({
    required this.contractUseCase,
  }) : super(const CandidateListState()) {
    on<GetCandidateAppliedListEvent>(getCandidateAppliedList);
    on<GetCandidateAppliedListMoreEvent>(getCandidateAppliedListMore);
    on<GetCandidateAppliedSearchEvent>(getCandidateAppliedSearch);
  }

  FutureOr<void> getCandidateAppliedList(GetCandidateAppliedListEvent event, Emitter<CandidateListState> emit) async {
    if (state is! GetCandidateAppliedListSuccess) {
      emit(state.copyWith(isLoading: true));
    }
    final candidateList = await contractUseCase.getCandidateApplied(
        event.post, GetCandidateApplied(page: 1, pageSize: 10, search: state.search));

    emit(GetCandidateAppliedListSuccess(
      candidateEntities: candidateList.data,
      meta: candidateList.meta,
      isLoading: false,
      loadMore: false,
      search: state.search,
      post: event.post,
    ));
  }

  FutureOr<void> getCandidateAppliedListMore(
      GetCandidateAppliedListMoreEvent event, Emitter<CandidateListState> emit) async {
    if (state is GetCandidateAppliedListSuccess) {
      emit((state as GetCandidateAppliedListSuccess).copyWith(loadMore: true));
      if (state.meta.currentPage >= state.meta.totalPage) {
        emit((state as GetCandidateAppliedListSuccess).copyWith(loadMore: false));
        return;
      }
      final candidateList = await contractUseCase.getCandidateApplied(
          state.post, GetCandidateApplied(page: state.meta.currentPage + 1, pageSize: 10, search: state.search));
      emit((state as GetCandidateAppliedListSuccess).copyWith(
          loadMore: false,
          candidateEntities: [...(state as GetCandidateAppliedListSuccess).candidateEntities, ...candidateList.data],
          meta: candidateList.meta));
    }
  }

  FutureOr<void> getCandidateAppliedSearch(
      GetCandidateAppliedSearchEvent event, Emitter<CandidateListState> emit) async {
    emit(state.copyWith(isLoading: true));
    final candidateList = await contractUseCase.getCandidateApplied(
        state.post, GetCandidateApplied(page: 1, pageSize: 10, search: event.search));

    emit(GetCandidateAppliedListSuccess(
        candidateEntities: candidateList.data,
        meta: candidateList.meta,
        isLoading: false,
        loadMore: false,
        search: event.search,
        post: state.post));
  }
}
