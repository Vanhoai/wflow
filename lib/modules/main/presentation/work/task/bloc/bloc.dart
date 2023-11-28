import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/enum/enum.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/modules/main/data/feedback/models/business_send_feedback_model.dart';
import 'package:wflow/modules/main/data/task/models/update_task_status_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_usecase.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
import 'package:wflow/modules/main/domain/task/task_usecase.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUseCase taskUseCase;
  final ContractUseCase contractUseCase;
  final FeedbackUseCase feedbackUseCase;
  TaskBloc({required this.taskUseCase, required this.contractUseCase, required this.feedbackUseCase})
      : super(const TaskState()) {
    on<InitEvent>(initial);
    on<GetTaskEvent>(getTask);
    on<UpdateTaskEvent>(updateTask);
    on<CheckContractAndTransfer>(checkContractAndTransfer);
    on<RatingEvent>(onRatingEvent);
  }

  FutureOr<void> getTask(GetTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! GetTaskListSuccessState) {
      emit(state.copyWith(isLoading: true));
    }
    final taskList = await taskUseCase.taskInContract(event.idContract);
    taskList.fold((List<TaskEntity> left) {
      bool isAllDone = false;
      for (int i = 0; i < left.length; i++) {
        if (left[i].state != TaskStatus.Accepted.name) {
          isAllDone = false;
          break;
        }
        isAllDone = true;
      }

      emit(GetTaskListSuccessState(
          taskEntities: left, isLoading: false, idContract: event.idContract, isAllDone: isAllDone));
    }, (Failure right) {
      emit(GetTaskListSuccessState(
          taskEntities: const [], isLoading: false, idContract: event.idContract, isAllDone: false));
    });
  }

  FutureOr<void> updateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    UpdateTaskStatusRequest request = UpdateTaskStatusRequest(id: event.id, status: event.status);
    emit(state.copyWith(isLoading: true));
    dynamic task;

    if (instance.get<AppBloc>().state.role == RoleEnum.user.index + 1) {
      task = await taskUseCase.workerUpdateStatusTask(request);
    } else {
      print('Role ${instance.get<AppBloc>().state.role == RoleEnum.user.index + 1}');
      task = await taskUseCase.businessUpdateStatusTask(request);
    }

    task.fold((TaskEntity left) {
      add(GetTaskEvent(idContract: (state as GetTaskListSuccessState).idContract));
    }, (Failure right) {
      emit(state.copyWith(isLoading: false));
    });
  }

  FutureOr<void> initial(InitEvent event, Emitter<TaskState> emit) {
    emit(const TaskState());
  }

  FutureOr<void> checkContractAndTransfer(CheckContractAndTransfer event, Emitter<TaskState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await contractUseCase.checkContractAndTransfer(event.id as int);
    response.fold(
      (String messages) {
        AlertUtils.showMessage(
          'Close Contract',
          messages,
          callback: () {
            AlertUtils.showMessage('Close Contract', messages);
          },
        );
      },
      (failure) {
        AlertUtils.showMessage('Close Contract', failure.message);
      },
    );
    emit(RatingState(isLoading: true, idContract: event.id));
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr<void> onRatingEvent(RatingEvent event, Emitter<TaskState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final BusinessSendFeedbackModel request = BusinessSendFeedbackModel(
      star: event.star,
      description: event.description,
      businessID: event.businessID,
      userID: event.userID,
    );
    final response = await feedbackUseCase.businessSendFeedback(request);
    response.fold(
      (String messages) {
        AlertUtils.showMessage(
          instance.get<AppLocalization>().translate('rating'),
          instance.get<AppLocalization>().translate('ratingSuccess'),
          callback: () {
            instance.get<NavigationService>().popUntil(2);
          },
        );
      },
      (failure) {
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('rating'),
            instance.get<AppLocalization>().translate('ratingFailed'));
      },
    );
    emit(const TaskState());
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
