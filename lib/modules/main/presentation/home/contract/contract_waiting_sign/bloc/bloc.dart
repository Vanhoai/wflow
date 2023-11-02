import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

part 'event.dart';
part 'state.dart';

class ContractWaitingSignBloc extends Bloc<ContractWaitingSignEvent, ContractWaitingSignState> {
  final ContractUseCase contractUseCase;

  ContractWaitingSignBloc({required this.contractUseCase})
      : super(const ContractWaitingSignState(
          contracts: [],
          isLoading: false,
        )) {
    on<ContractWaitingSignEventFetch>(onFetch);
    on<ContractWaitingSignEventSearch>(onSearch);
    on<ContractWaitingSignEventClearSearch>(onClearSearch);
    on<ContractWaitingSignEventRefresh>(onRefresh);
    on<ContractWaitingSignEventLoadMore>(onLoadMore);
  }

  FutureOr<void> onFetch(ContractWaitingSignEventFetch event, Emitter<ContractWaitingSignState> emit) async {}

  FutureOr<void> onSearch(ContractWaitingSignEventSearch event, Emitter<ContractWaitingSignState> emit) async {}

  FutureOr<void> onClearSearch(
      ContractWaitingSignEventClearSearch event, Emitter<ContractWaitingSignState> emit) async {}

  FutureOr<void> onRefresh(ContractWaitingSignEventRefresh event, Emitter<ContractWaitingSignState> emit) async {}

  FutureOr<void> onLoadMore(ContractWaitingSignEventLoadMore event, Emitter<ContractWaitingSignState> emit) async {}
}
