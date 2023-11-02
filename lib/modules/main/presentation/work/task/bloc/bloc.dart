import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
import 'package:wflow/modules/main/domain/task/task_usecase.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUseCase taskUseCase;

  TaskBloc({required this.taskUseCase}) : super(const TaskState()) {
    on<GetTaskEvent>(getTask);
  }

  FutureOr<void> getTask(GetTaskEvent event, Emitter<TaskState> emit) async {
    if (state is! GetTaskListSuccessState) {
      emit(state.copyWith(isLoading: true));
    }
    final taskList = await taskUseCase.taskInContract(event.idContract);
    taskList.fold((List<TaskEntity> left) {
      emit(GetTaskListSuccessState(taskEntities: left, isLoading: false));
    }, (Failure right) {
      emit(const GetTaskListSuccessState(taskEntities: [], isLoading: false));
    });
  }
}
