part of 'bloc.dart';

abstract class UpPostEvent {}

class UpPostAddTaskEvent extends UpPostEvent {
  final String task;

  UpPostAddTaskEvent(this.task);
}

class EditTaskEvent extends UpPostEvent {
  final int index;
  final String task;

  EditTaskEvent(this.index, this.task);
}

class RemoveLastTaskEvent extends UpPostEvent {}
