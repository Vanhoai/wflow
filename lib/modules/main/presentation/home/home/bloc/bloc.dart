import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostUseCase postUseCase;
  final CategoryUseCase categoryUseCase;
  final UserUseCase userUseCase;

  HomeBloc({
    required this.postUseCase,
    required this.categoryUseCase,
    required this.userUseCase,
  }) : super(const HomeState(recentJobs: [], hotJobs: [], categories: [])) {
    on<HomeInitialEvent>(onInit);
    on<OnSelectCategoryEvent>(onSelectCategory);
  }

  Future<void> getMyProfile() async {
    final response = await userUseCase.myProfile();
    response.fold(
      (UserEntity userEntity) {
        final authEntity = instance.get<AppBloc>().state.authEntity;
        instance.get<AppBloc>().add(AppChangeUser(userEntity: userEntity));
        instance.get<AppBloc>().add(AppChangeAuth(authEntity: authEntity, role: userEntity.role));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
      },
    );
  }

  FutureOr onInit(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    await getMyProfile();
    final categories = await categoryUseCase.getPostCategory();

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
