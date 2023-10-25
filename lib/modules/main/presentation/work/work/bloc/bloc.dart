import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';

part 'event.dart';
part 'state.dart';

class WorkBloc extends Bloc<WorkEvent, WorkState> {
  final PostUseCase postUseCase;

  WorkBloc({required this.postUseCase}) : super(const WorkState(categories: [], posts: [])) {
    on<WorkInitialEvent>(onInitial);
    on<OnSelectCategoryEvent>(onSelectCategory);
    on<RefreshEvent>(onRefresh);
    on<LoadMoreEvent>(onLoadMore);
  }

  FutureOr<void> getPost(GetPostWithCategory request, Emitter<WorkState> emit, String category) async {
    final response = await postUseCase.getPostWithCategory(request);

    emit(
      state.copyWith(
        posts: response.data,
        meta: response.meta,
      ),
    );
  }

  FutureOr<void> onInitial(WorkInitialEvent event, Emitter<WorkState> emit) async {
    emit(state.copyWith(isLoading: true));

    final categories = await postUseCase.getPostCategories();
    emit(state.copyWith(categories: categories, categorySelected: categories.first.name));
    await getPost(
      GetPostWithCategory(page: 1, pageSize: 10, category: categories.first.name),
      emit,
      categories.first.name,
    );

    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> onSelectCategory(OnSelectCategoryEvent event, Emitter<WorkState> emit) async {
    emit(state.copyWith(isLoading: true));

    emit(state.copyWith(categorySelected: event.category));
    await getPost(
      GetPostWithCategory(page: 1, pageSize: 10, category: event.category),
      emit,
      event.category,
    );

    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> onRefresh(RefreshEvent event, Emitter<WorkState> emit) async {
    emit(state.copyWith(isLoading: true));

    await getPost(
      GetPostWithCategory(page: 1, pageSize: 10, category: state.categorySelected),
      emit,
      state.categorySelected,
    );

    emit(state.copyWith(isLoading: false));
  }

  FutureOr<void> onLoadMore(LoadMoreEvent event, Emitter<WorkState> emit) async {
    emit(state.copyWith(isLoading: true));

    if (state.meta.currentPage >= state.meta.totalPage) {
      emit(state.copyWith(messageNotification: 'No more data'));
      emit(state.copyWith(messageNotification: ''));
      return;
    }

    final response = await postUseCase.getPostWithCategory(
      GetPostWithCategory(
        page: state.meta.currentPage + 1,
        pageSize: 10,
        category: state.categorySelected,
      ),
    );

    emit(
      state.copyWith(
        posts: [...state.posts, ...response.data],
        meta: response.meta,
      ),
    );

    emit(state.copyWith(isLoading: false));
  }
}
