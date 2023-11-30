import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/contract/model/request_apply_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';
import 'package:wflow/modules/main/presentation/home/apply/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/apply/bloc/state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  final ContractUseCase contractUseCase;
  ApplyBloc({required this.contractUseCase}) : super(const ApplyState()) {
    on<InitApplyEvent>(onInitApply);
    on<ScrollApplyEvent>(onScrollApply);
  }

  Future<void> onInitApply(InitApplyEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final result = await contractUseCase.getContractApplies(
      RequestApplyModel(page: 1, pageSize: 10, search: ''),
    );

    result.fold(
        (HttpResponseWithPagination<ContractEntity> httpResponseWithPagination) =>
            emit(state.copyWith(applies: httpResponseWithPagination.data, meta: httpResponseWithPagination.meta)),
        (Failure failure) => {});

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onScrollApply(ScrollApplyEvent event, Emitter emit) async {
    if (state.meta.currentPage < state.meta.totalPage) {
      emit(LoadMoreApplySate());

      List<ContractEntity> newApplies = [];
      final result = await contractUseCase.getContractApplies(RequestApplyModel(
        page: state.meta.currentPage.toInt() + 1,
        pageSize: state.meta.pageSize.toInt(),
        search: '',
      ));
      result.fold((HttpResponseWithPagination<ContractEntity> httpResponseWithPagination) {
        newApplies = [
          ...state.applies.map((e) => ContractEntity.fromJson(e.toJson())),
          ...httpResponseWithPagination.data.map((e) => ContractEntity.fromJson(e.toJson()))
        ];
        emit(ApplyState(applies: newApplies, meta: httpResponseWithPagination.meta));
      }, (Failure failure) => {});
    }
  }
}
