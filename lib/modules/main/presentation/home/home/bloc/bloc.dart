import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostUseCase postUseCase;
  HomeBloc({required this.postUseCase}) : super(HomeState(recentJobs: [], hotJobs: [], categories: [])) {
    on<HomeInitialEvent>(onInit);
    on<OnSelectCategoryEvent>(onSelectCategory);
  }

  FutureOr onInit(HomeInitialEvent event, Emitter<HomeState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final future = await Future.wait([
      postUseCase.getRecentJobs(),
      postUseCase.getHotJobs(),
      postUseCase.getPostCategories(),
    ]);

    final recentJobs = future[0] as List<PostEntity>;
    final hotJobs = future[1] as List<PostEntity>;
    final categories = future[2] as List<CategoryEntity>;

    emit(state.copyWith(recentJobs: recentJobs, hotJobs: hotJobs, categories: categories));
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr onSelectCategory(OnSelectCategoryEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(categorySelected: event.category));
  }
}
