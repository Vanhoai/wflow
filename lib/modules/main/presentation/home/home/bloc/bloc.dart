import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostUseCase postUseCase;
  HomeBloc({required this.postUseCase}) : super(const HomeState(recentJobs: [], hotJobs: [], categories: [])) {
    on<HomeInitialEvent>(onInit);
    on<OnSelectCategoryEvent>(onSelectCategory);
  }

  FutureOr onInit(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final categories = await postUseCase.getPostCategories();

    final future = await Future.wait([
      postUseCase.getHotJobs(),
      postUseCase.getRecentJobs(categories.first.name),
    ]);

    final hotJobs = future[0];
    final recentJobs = future[1];

    emit(
      state.copyWith(
        recentJobs: recentJobs,
        hotJobs: hotJobs,
        categories: categories,
        isLoading: false,
        categorySelected: categories.first.name,
      ),
    );
  }

  FutureOr onSelectCategory(OnSelectCategoryEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(categorySelected: event.category, loadingCategory: true));
    final posts = await postUseCase.getRecentJobs(event.category);
    emit(state.copyWith(recentJobs: posts));

    emit(state.copyWith(loadingCategory: false));
  }
}
