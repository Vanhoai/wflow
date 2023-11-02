import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

part 'event.dart';
part 'state.dart';

class ContractWaitingSignBloc extends Bloc<ContractWaitingSignEvent, ContractWaitingSignState> {
  final ContractUseCase contractUseCase;

  ContractWaitingSignBloc({required this.contractUseCase})
      : super(ContractWaitingSignState(contracts: const [], meta: Meta.empty(), isLoading: false)) {
    on<ContractWaitingSignEventFetch>(onFetch);
    on<ContractWaitingSignEventSearch>(onSearch);
    on<ContractWaitingSignEventClearSearch>(onClearSearch);
    on<ContractWaitingSignEventRefresh>(onRefresh);
    on<ContractWaitingSignEventLoadMore>(onLoadMore);
  }

  FutureOr<void> onFetch(ContractWaitingSignEventFetch event, Emitter<ContractWaitingSignState> emit) async {
    emit(state.copyWith(isLoading: true));

    final contracts = await contractUseCase.findContractWaitingSign(
      const GetContractWaitingSign(
        page: 1,
        pageSize: 10,
        search: '',
      ),
    );

    emit(state.copyWith(
      contracts: contracts.data,
      meta: contracts.meta,
      isLoading: false,
    ));
  }

  FutureOr<void> onSearch(ContractWaitingSignEventSearch event, Emitter<ContractWaitingSignState> emit) async {
    emit(state.copyWith(isLoading: true));

    final contracts = await contractUseCase.findContractWaitingSign(
      GetContractWaitingSign(
        page: 1,
        pageSize: 10,
        search: event.search,
      ),
    );

    emit(state.copyWith(
      contracts: contracts.data,
      meta: contracts.meta,
      isLoading: false,
    ));
  }

  FutureOr<void> onClearSearch(
      ContractWaitingSignEventClearSearch event, Emitter<ContractWaitingSignState> emit) async {
    emit(state.copyWith(isLoading: true));

    final contracts = await contractUseCase.findContractWaitingSign(
      const GetContractWaitingSign(
        page: 1,
        pageSize: 10,
        search: '',
      ),
    );

    emit(state.copyWith(
      contracts: contracts.data,
      meta: contracts.meta,
      isLoading: false,
    ));
  }

  FutureOr<void> onRefresh(ContractWaitingSignEventRefresh event, Emitter<ContractWaitingSignState> emit) async {
    emit(state.copyWith(isLoading: true));

    final contracts = await contractUseCase.findContractWaitingSign(
      const GetContractWaitingSign(
        page: 1,
        pageSize: 10,
        search: '',
      ),
    );

    emit(state.copyWith(
      contracts: contracts.data,
      meta: contracts.meta,
      isLoading: false,
    ));
  }

  FutureOr<void> onLoadMore(ContractWaitingSignEventLoadMore event, Emitter<ContractWaitingSignState> emit) async {
    emit(state.copyWith(isLoading: true));

    final contracts = await contractUseCase.findContractWaitingSign(
      GetContractWaitingSign(
        page: state.meta.currentPage + 1,
        pageSize: 10,
        search: '',
      ),
    );

    emit(state.copyWith(
      contracts: [...state.contracts, ...contracts.data],
      meta: contracts.meta,
      isLoading: false,
    ));
  }
}
