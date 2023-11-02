import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';

import 'event.dart';
import 'state.dart';

class JobInformationBloc extends Bloc<JobInformationEvent, JobInformationState> {
  final PostUseCase postUseCase;
  final ContractUseCase contractUseCase;
  JobInformationBloc({required this.postUseCase, required this.contractUseCase}) : super(const JobInformationState()) {
    on<GetJobInformationEvent>(getJobInformation);
    on<ApplyPostEvent>(applyPost);
  }

  FutureOr<void> getJobInformation(GetJobInformationEvent event, Emitter<JobInformationState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await postUseCase.getPostId(event.id);
    response.fold((PostEntity left) {
      emit(GetJobInformationSuccessState(postEntity: left, isLoading: false));
    }, (Failure right) {
      emit(const GetJobInformationFailureState());
    });
  }

  FutureOr<void> applyPost(ApplyPostEvent event, Emitter<JobInformationState> emit) async {
    if (state is GetJobInformationSuccessState) {
      emit(state.copyWith(isLoading: true));
      final response = await contractUseCase.applyPost(ApplyPostRequest(post: event.post, cv: event.cv));
      response.fold((String left) {
        emit(ApplyPostState(
            message: left, postEntity: (state as GetJobInformationSuccessState).postEntity, isLoading: false));
      }, (Failure right) {
        emit(ApplyPostState(
            message: right.message, postEntity: (state as GetJobInformationSuccessState).postEntity, isLoading: false));
      });
    }
  }
}
