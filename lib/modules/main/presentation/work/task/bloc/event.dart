import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class GetTaskEvent extends TaskEvent {
  final num idContract;

  const GetTaskEvent({required this.idContract});
  @override
  List<Object?> get props => [idContract];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}
