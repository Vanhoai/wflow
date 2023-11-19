import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/enum/enum.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/state.dart';

class ContractHistoryBloc
    extends Bloc<ContractHistoryEvent, ContractHistoryState> {
  final ContractUseCase contractUseCase;
  late final bool isBusiness;
  ContractHistoryBloc({required this.contractUseCase})
      : super(const ContractHistoryState()) {
    on<InitContractHistoryEvent>(onInitContractHistoryEvent);
    on<ScrollContractHistoryEvent>(onScrollContractHistoryEvent);
  }

  Future<void> onInitContractHistoryEvent(
      InitContractHistoryEvent event, Emitter emit) async {
    isBusiness = instance.get<AppBloc>().state.userEntity.role !=
        RoleEnum.user.index + 1;

    final result = await contractUseCase.getContractCompleted(GetContractSigned(
        isBusiness: isBusiness,
        page: state.meta.currentPage,
        pageSize: state.meta.pageSize,
        search: state.txtSearch));

    result.fold(
        (httpResponseWithPagination) => {
              emit(state.copyWith(
                  contractHistories: httpResponseWithPagination.data,
                  meta: httpResponseWithPagination.meta))
            },
        (failure) => {});
  }

  Future<void> onScrollContractHistoryEvent(
      ScrollContractHistoryEvent event, Emitter emit) async {
    if (state.meta.currentPage < state.meta.totalPage ||
        state.meta.currentPage == 1) {
      final result = await contractUseCase.getContractCompleted(
          GetContractSigned(
              isBusiness: isBusiness,
              page: state.meta.currentPage + 1,
              pageSize: state.meta.pageSize,
              search: state.txtSearch));

      result.fold(
          (httpResponseWithPagination) => {
                emit(state.copyWith(
                    contractHistories: httpResponseWithPagination.data,
                    meta: httpResponseWithPagination.meta))
              },
          (failure) => {});
    }
  }
}
