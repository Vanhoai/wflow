import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/event.dart';

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
    on<ToggleBookmarkHomeEvent>(onToggleBookmark);
    on<ToggleBookmarkRecentHomeEvent>(onToggleBookmarkRecent);
  }

  Future<void> getMyProfile() async {
    final response = await userUseCase.myProfile();
    late int topicBusiness = 0;

    response.fold(
      (UserEntity userEntity) {
        final authEntity = instance.get<AppBloc>().state.authEntity;
        instance.get<AppBloc>().add(AppChangeUser(userEntity: userEntity));
        instance.get<AppBloc>().add(AppChangeAuth(authEntity: authEntity, role: userEntity.role));

        topicBusiness = userEntity.business;
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
        return null;
      },
    );

    if (topicBusiness != 0) {
      await FirebaseMessagingService.subscribeToTopic(topicBusiness.toString());
      print('Subscribed to topic ${topicBusiness.toString()}');
    }
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

    final List<bool> bookmarks = [...hotJobs.map((e) => e.isBookmarked)];
    final List<bool> bookmarksRecent = [...recentJobs.map((e) => e.isBookmarked)];

    print('Bookmark ${hotJobs.toList()}');

    emit(
      state.copyWith(
        recentJobs: recentJobs,
        hotJobs: hotJobs,
        categories: categories,
        isLoading: false,
        categorySelected: categories.first.name,
        bookmarks: bookmarks,
        bookmarksRecent: bookmarksRecent,
      ),
    );
  }

  FutureOr onSelectCategory(OnSelectCategoryEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(categorySelected: event.category, loadingCategory: true));
    final posts = await postUseCase.getRecentJobs(event.category);
    List<bool> bookmarksRecent = [...posts.map((e) => e.isBookmarked)];
    emit(state.copyWith(
      recentJobs: posts,
      bookmarksRecent: bookmarksRecent,
    ));

    emit(state.copyWith(loadingCategory: false));
  }

  Future<void> onToggleBookmark(ToggleBookmarkHomeEvent event, Emitter emit) async {
    instance.get<BookmarkBloc>().add(ToggleBookmarkEvent(id: event.id));

    List<bool> newBookmarks = [...state.bookmarks];
    newBookmarks[event.index] = event.isBookmarkeded;

    emit(state.copyWith(bookmarks: newBookmarks));
  }

  Future<void> onToggleBookmarkRecent(ToggleBookmarkRecentHomeEvent event, Emitter emit) async {
    instance.get<BookmarkBloc>().add(ToggleBookmarkEvent(id: event.id));

    List<bool> newBookmarksRecent = [...state.bookmarksRecent];
    newBookmarksRecent[event.index] = event.isBookmarkeded;

    emit(state.copyWith(bookmarksRecent: newBookmarksRecent));
  }
}
