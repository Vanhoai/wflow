import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

class TaskState extends Equatable {
  final bool isLoading;
  final bool isAllDone;
  const TaskState({this.isLoading = false, this.isAllDone = false});

  TaskState copyWith({bool? isLoading}) {
    return TaskState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading, isAllDone];
}

class GetTaskListSuccessState extends TaskState {
  final List<TaskEntity> taskEntities;
  final num idContract;
  const GetTaskListSuccessState({
    required this.taskEntities,
    required super.isLoading,
    required this.idContract,
    required super.isAllDone,
  });

  @override
  GetTaskListSuccessState copyWith({
    bool? isLoading,
    List<TaskEntity>? taskEntities,
    num? idContract,
    bool? isAllDone,
  }) {
    return GetTaskListSuccessState(
        taskEntities: taskEntities ?? this.taskEntities,
        isLoading: isLoading ?? super.isLoading,
        isAllDone: isAllDone ?? super.isAllDone,
        idContract: idContract ?? this.idContract);
  }

  @override
  List<Object?> get props => [isLoading, taskEntities, isAllDone, idContract];
}
