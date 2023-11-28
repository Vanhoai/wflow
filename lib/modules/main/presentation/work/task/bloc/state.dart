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

class RatingState extends TaskState {
  final num idContract;
  const RatingState({
    required super.isLoading,
    required this.idContract,
  });

  @override
  RatingState copyWith({
    bool? isLoading,
    num? idContract,
  }) {
    return RatingState(
      isLoading: isLoading ?? super.isLoading,
      idContract: idContract ?? this.idContract,
    );
  }

  @override
  List<Object?> get props => [isLoading, idContract];
}

class RatingSuccessState extends TaskState {
  final String message;

  const RatingSuccessState({
    required this.message,
  });

  @override
  RatingSuccessState copyWith({
    String? message,
    bool? isLoading,
  }) {
    return RatingSuccessState(
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [message];
}
