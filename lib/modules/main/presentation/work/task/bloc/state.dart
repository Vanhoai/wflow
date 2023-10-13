import 'package:equatable/equatable.dart';

class Task {
  final int id;
  final String title;
  final String content;
  final String end;
  final String status;

  Task(
      {required this.id,
      required this.title,
      required this.content,
      required this.end,
      required this.status});
}

class TaskState extends Equatable {
  final List<Task> listTask;

  const TaskState({required this.listTask});

  TaskState copyWith({List<Task>? listTask}) {
    return TaskState(listTask: listTask ?? this.listTask);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [listTask];
}
