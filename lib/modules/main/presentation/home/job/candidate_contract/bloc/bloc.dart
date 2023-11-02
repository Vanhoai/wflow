import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/bloc/state.dart';

class CandidateDetailBloc extends Bloc<CandidateDetailEvent, CandidateDetailState> {
  final ContractUseCase contractUseCase;
  CandidateDetailBloc({required this.contractUseCase}) : super(const CandidateDetailState()) {
    on<GetCandidateDetailEvent>(getCandidateDetail);
  }

  FutureOr<void> getCandidateDetail(GetCandidateDetailEvent event, Emitter<CandidateDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await contractUseCase.candidateAppliedDetail(event.id);
    response.fold((ContractEntity left) {
      emit(GetCandidateDetailSuccessState(contractEntity: left, isLoading: false));
    }, (Failure right) {
      emit(const GetCandidateDetailFailureState());
    });
  }
}
