

import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/state.dart';

class TaskEvent extends Equatable{
  const TaskEvent();
  @override
  List<Object?> get props => [];

}
class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];

}