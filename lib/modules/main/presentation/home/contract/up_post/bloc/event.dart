part of 'bloc.dart';

abstract class UpPostEvent {}

class UpPostInitialEvent extends UpPostEvent {}

class ToggleSkillEvent extends UpPostEvent {
  final CategoryEntity categoryEntity;

  ToggleSkillEvent(this.categoryEntity);
}

class ToggleCategoryEvent extends UpPostEvent {
  final CategoryEntity categoryEntity;

  ToggleCategoryEvent(this.categoryEntity);
}

class UpPostAddTaskEvent extends UpPostEvent {}

class EditTaskEvent extends UpPostEvent {
  final int index;
  final String task;

  EditTaskEvent(this.index, this.task);
}

class RemoveLastTaskEvent extends UpPostEvent {}
