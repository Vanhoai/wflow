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

    final future = await Future.wait([
      postUseCase.getRecentJobs(),
      postUseCase.getHotJobs(),
      postUseCase.getPostCategories(),
    ]);

    final recentJobs = future[0] as List<PostEntity>;
    final hotJobs = future[1] as List<PostEntity>;
    final categories = future[2] as List<CategoryEntity>;

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
    emit(state.copyWith(categorySelected: event.category));
  }
}
