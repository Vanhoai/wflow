import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class UpPostBloc extends Bloc<UpPostEvent, UpPostState> {
  UpPostBloc() : super(const UpPostState(tasks: ['Simple task'])) {
    on<UpPostAddTaskEvent>(onAddTask);
    on<EditTaskEvent>(onEditTask);
    on<RemoveLastTaskEvent>(onRemoveLastTask);
  }

  FutureOr<void> onAddTask(UpPostAddTaskEvent event, Emitter<UpPostState> emit) async {
    emit(state.copyWith(tasks: [...state.tasks, event.task]));
  }

  FutureOr<void> onEditTask(EditTaskEvent event, Emitter<UpPostState> emit) async {
    final List<String> tasks = state.tasks;
    tasks[event.index] = event.task;
    emit(state.copyWith(tasks: tasks));
  }

  FutureOr<void> onRemoveLastTask(RemoveLastTaskEvent event, Emitter<UpPostState> emit) async {
    final List<String> tasks = state.tasks;
    tasks.removeLast();
    emit(state.copyWith(tasks: tasks));
  }
}
