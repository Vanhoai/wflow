import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/bloc/state.dart';

class ContractListBloc extends Bloc<ContractEvent, ContractListState> {
  final ContractUseCase contractUseCase;
  ContractListBloc({required this.contractUseCase}) : super(const ContractListState()) {
    on<GetListContractEvent>(getListContract);
    on<GetListContractMoreEvent>(getListContractMore);
    on<GetListContractSearchEvent>(getListContractSearch);
  }

  Future<FutureOr<void>> getListContract(GetListContractEvent event, Emitter<ContractListState> emit) async {
    if (state is! GetContractListSuccessState) {
      emit(state.copyWith(isLoading: true));
    }
    final contractList = await contractUseCase
        .findContractAcceptedOfUser(GetCandidateApplied(page: 1, pageSize: 10, search: state.search));

    emit(GetContractListSuccessState(
      contractEntities: contractList.data,
      meta: contractList.meta,
      isLoading: false,
      loadMore: false,
      search: state.search,
    ));
  }

  FutureOr<void> getListContractMore(GetListContractMoreEvent event, Emitter<ContractListState> emit) async {
    if (state is GetContractListSuccessState) {
      emit((state as GetContractListSuccessState).copyWith(loadMore: true));
      if (state.meta.currentPage >= state.meta.totalPage) {
        emit((state as GetContractListSuccessState).copyWith(loadMore: false));
        return;
      }
      final contractList = await contractUseCase.findContractAcceptedOfUser(
          GetCandidateApplied(page: state.meta.currentPage + 1, pageSize: 10, search: state.search));
      emit((state as GetContractListSuccessState).copyWith(
          loadMore: false,
          contractEntities: [...(state as GetContractListSuccessState).contractEntities, ...contractList.data],
          meta: contractList.meta));
    }
  }

  FutureOr<void> getListContractSearch(GetListContractSearchEvent event, Emitter<ContractListState> emit) async {
    emit(state.copyWith(isLoading: true));
    final contractList = await contractUseCase
        .findContractAcceptedOfUser(GetCandidateApplied(page: 1, pageSize: 10, search: event.search));

    emit(GetContractListSuccessState(
      contractEntities: contractList.data,
      meta: contractList.meta,
      isLoading: false,
      loadMore: false,
      search: event.search,
    ));
  }
}
