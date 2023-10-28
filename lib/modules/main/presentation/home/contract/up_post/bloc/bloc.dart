import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class UpPostBloc extends Bloc<UpPostEvent, UpPostState> {
  UpPostBloc() : super(const UpPostState(tasks: ['Simple task'])) {
    on<EditTaskEvent>(onEditTask);
    on<UpPostAddTaskEvent>(onAddTask);
    on<RemoveLastTaskEvent>(onRemoveLastTask);
  }

  FutureOr<void> onAddTask(UpPostAddTaskEvent event, Emitter<UpPostState> emit) async {
    final List<String> tasks = [...state.tasks, 'Simple task'];
    emit(state.copyWith(tasks: tasks));
  }

  FutureOr<void> onEditTask(EditTaskEvent event, Emitter<UpPostState> emit) async {
    List<String> tasks = [...state.tasks];
    tasks[event.index] = event.task;
    emit(state.copyWith(tasks: tasks));
  }

  FutureOr<void> onRemoveLastTask(RemoveLastTaskEvent event, Emitter<UpPostState> emit) async {
    if (state.tasks.isNotEmpty) {
      final List<String> tasks = state.tasks.sublist(0, state.tasks.length - 1);
      emit(state.copyWith(tasks: tasks));
    }
  }
}
