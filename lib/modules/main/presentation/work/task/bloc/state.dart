import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

class TaskState extends Equatable {
  final bool isLoading;

  const TaskState({this.isLoading = false});

  TaskState copyWith({bool? isLoading}) {
    return TaskState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}

class GetTaskListSuccessState extends TaskState {
  final List<TaskEntity> taskEntities;
  const GetTaskListSuccessState({required this.taskEntities, required super.isLoading});

  @override
  GetTaskListSuccessState copyWith({bool? isLoading, List<TaskEntity>? taskEntities}) {
    return GetTaskListSuccessState(
        taskEntities: taskEntities ?? this.taskEntities, isLoading: isLoading ?? super.isLoading);
  }

  @override
  List<Object?> get props => [isLoading, taskEntities];
}
