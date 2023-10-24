import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/state.dart';

class JobInformationBloc
    extends Bloc<JobInformationEvent, JobInformationState> {
  final PostUseCase postUseCase;
  JobInformationBloc({required this.postUseCase})
      : super(const JobInformationState()) {
    on<GetJobInformationEvent>(getJobInformation);
  }

  FutureOr<void> getJobInformation(
      GetJobInformationEvent event, Emitter<JobInformationState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await postUseCase.getPostId(event.id);
    response.fold((PostEntity left) {
      emit(GetJobInformationSuccessState(postEntity: left, isLoading: false));
    }, (Failure right) {
      emit(const GetJobInformationFailureState());
    });
  }
}
