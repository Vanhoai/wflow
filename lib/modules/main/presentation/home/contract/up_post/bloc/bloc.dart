import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';

part 'event.dart';
part 'state.dart';

class UpPostBloc extends Bloc<UpPostEvent, UpPostState> {
  final CategoryUseCase categoryUseCase;
  final ContractUseCase contractUseCase;

  UpPostBloc({
    required this.categoryUseCase,
    required this.contractUseCase,
  }) : super(const UpPostState(tasks: ['Simple task'], categories: [], skills: [])) {
    on<EditTaskEvent>(onEditTask);
    on<UpPostAddTaskEvent>(onAddTask);
    on<RemoveLastTaskEvent>(onRemoveLastTask);
    on<UpPostInitialEvent>(onInitialUpPost);
  }

  FutureOr<void> onInitialUpPost(UpPostInitialEvent event, Emitter<UpPostState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final future = await Future.wait([
      categoryUseCase.getPostCategory(),
      categoryUseCase.getSkillCategory(),
    ]);

    final categories = future[0];
    final skills = future[1];

    emit(state.copyWith(categories: categories, skills: skills));
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
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
