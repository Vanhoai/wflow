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

class UpPostAddTaskEvent extends UpPostEvent {
  final String task;

  UpPostAddTaskEvent({required this.task});
}

class EditTaskEvent extends UpPostEvent {
  final int index;
  final String task;

  EditTaskEvent(this.index, this.task);
}

class RemoveLastTaskEvent extends UpPostEvent {}
class AddTaskWithExcel extends UpPostEvent{
  final File file;

  AddTaskWithExcel({required this.file});
}
class UpPostSubmitEvent extends UpPostEvent {
  final String title;
  final String description;
  final String budget;
  final String duration;
  final String position;

  UpPostSubmitEvent({
    required this.title,
    required this.description,
    required this.budget,
    required this.duration,
    required this.position,
  });
}
