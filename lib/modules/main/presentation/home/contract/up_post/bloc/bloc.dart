import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/post/models/request/up_post_rqst.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';

part 'event.dart';
part 'state.dart';

class UpPostBloc extends Bloc<UpPostEvent, UpPostState> {
  final CategoryUseCase categoryUseCase;
  final ContractUseCase contractUseCase;
  final PostUseCase postUseCase;

  UpPostBloc({
    required this.categoryUseCase,
    required this.contractUseCase,
    required this.postUseCase,
  }) : super(const UpPostState(tasks: [], categories: [], skills: [])) {
    on<EditTaskEvent>(onEditTask);
    on<UpPostAddTaskEvent>(onAddTask);
    on<RemoveLastTaskEvent>(onRemoveLastTask);
    on<UpPostInitialEvent>(onInitialUpPost);
    on<ToggleSkillEvent>(onToggleSkill);
    on<ToggleCategoryEvent>(onToggleCategory);
    on<UpPostSubmitEvent>(onUpPostSubmit);
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

  FutureOr<void> onToggleSkill(ToggleSkillEvent event, Emitter<UpPostState> emit) {
    final skillSelected = [...state.skillSelected];
    if (skillSelected.contains(event.categoryEntity)) {
      skillSelected.remove(event.categoryEntity);
    } else {
      skillSelected.add(event.categoryEntity);
    }

    emit(state.copyWith(skillSelected: skillSelected));
  }

  FutureOr<void> onToggleCategory(ToggleCategoryEvent event, Emitter<UpPostState> emit) {
    final categorySelected = [...state.categorySelected];
    if (categorySelected.contains(event.categoryEntity)) {
      categorySelected.remove(event.categoryEntity);
    } else {
      categorySelected.add(event.categoryEntity);
    }

    emit(state.copyWith(categorySelected: categorySelected));
  }

  FutureOr<void> onAddTask(UpPostAddTaskEvent event, Emitter<UpPostState> emit) async {
    final List<String> tasks = [...state.tasks, event.task];
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

  Future<void> onUpPostSubmit(UpPostSubmitEvent event, Emitter<UpPostState> emit) async {
    final [isValid, message] = validate(event);
    if (!isValid) {
      AlertUtils.showMessage('Thông báo', message, callback: () {
        if (state.categorySelected.isNotEmpty && state.tasks.isEmpty) {
          add(UpPostAddTaskEvent(task: event.title));
        }
      });
      return;
    }

    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final business = instance.get<AppBloc>().state.userEntity.business;
    final UpPostRequest request = UpPostRequest(
      title: event.title,
      content: event.description,
      duration: event.duration.isEmpty ? 'Không có thông tin' : event.duration,
      salary: num.parse(event.budget),
      position: event.position,
      business: business,
      categories: state.categorySelected.map((e) => e.id).toList(),
      tags: state.skillSelected.map((e) => e.id).toList(),
      tasks: state.tasks,
    );

    final response = await postUseCase.upPost(request: request);
    response.fold(
      (String message) {
        AlertUtils.showMessage('Thông báo', message, callback: () {
          instance.get<NavigationService>().pop();
        });
      },
      (Failure failure) {
        AlertUtils.showMessage('Thông báo', failure.message);
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  List<dynamic> validate(UpPostSubmitEvent event) {
    bool isValid = true;
    String message = '';

    if (state.tasks.isEmpty) {
      isValid = false;
      message =
          'Nếu bạn không nhập đầu việc nào cho công việc thì chúng tôi sẽ tạo mặt định 1 đầu việc chính là công việc này !!';
    }

    if (state.skillSelected.isEmpty) {
      isValid = false;
      message = 'Vui lòng chọn ít nhất 1 kỹ năng';
    }

    if (state.categorySelected.isEmpty) {
      isValid = false;
      message = 'Vui lòng chọn ít nhất 1 danh mục';
    }

    if (event.position.isEmpty) {
      isValid = false;
      message = 'Vui lòng nhập vị trí cho công việc';
    }

    if (event.budget.isEmpty) {
      isValid = false;
      message = 'Vui lòng nhập giá tiền cho công việc';
    }

    if (event.description.isEmpty) {
      isValid = false;
      message = 'Vui lòng nhập mô tả cho công việc';
    }

    if (event.title.isEmpty) {
      isValid = false;
      message = 'Vui lòng nhập tiêu đề công việc';
    }

    return [isValid, message];
  }
}
