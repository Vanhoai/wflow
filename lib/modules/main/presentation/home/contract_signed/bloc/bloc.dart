import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/enum/role_enum.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

part 'event.dart';
part 'state.dart';

class ContractSignedBloc extends Bloc<ContractSignedEvent, ContractSignedState> {
  final ContractUseCase contractUseCase;

  ContractSignedBloc({required this.contractUseCase})
      : super(ContractSignedState(
          contracts: const [],
          isLoadMore: false,
          isLoading: false,
          meta: Meta.empty(),
        )) {
    on<ContractSignedEventFetch>(onFetch);
    on<ContractSignedEventRefresh>(onRefresh);
    on<ContractSignedEventLoadMore>(onLoadMore);
    on<ContractSignedSearchEvent>(onSearch);
  }

  FutureOr<void> onFetch(ContractSignedEventFetch event, Emitter<ContractSignedState> emit) async {
    emit(state.copyWith(isLoading: true));
    final isBusiness = instance.get<AppBloc>().state.role == RoleEnum.business.index + 1;

    final result = await contractUseCase.findContractSigned(
      GetContractSigned(page: 1, pageSize: 10, search: '', isBusiness: isBusiness),
    );

    emit(state.copyWith(
      contracts: result.data,
      meta: result.meta,
      isLoading: false,
    ));
  }

  FutureOr<void> onRefresh(ContractSignedEventRefresh event, Emitter<ContractSignedState> emit) async {}

  FutureOr<void> onLoadMore(ContractSignedEventLoadMore event, Emitter<ContractSignedState> emit) async {}

  FutureOr<void> onSearch(ContractSignedSearchEvent event, Emitter<ContractSignedState> emit) async {}
}
