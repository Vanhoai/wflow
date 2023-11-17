import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final PostUseCase postUseCase;
  BookmarkBloc({required this.postUseCase}) : super(const BookmarkState()) {
    on<InitBookmarkEvent>(onInitPostSaved);
    on<ScrollBookmarkEvent>(onScrollPostSaved);
    on<ToggleBookmarkEvent>(onToggleBookmarkPostSaved);
  }

  Future<void> onInitPostSaved(InitBookmarkEvent event, Emitter emit) async {
    final result = await postUseCase
        .getPostsSaved(const GetWorkModel(page: 1, pageSize: 10, search: ''));

    result.fold(
        (HttpResponseWithPagination<PostEntity> httpResponseWithPagination) => {
              emit(BookmarkState(
                posts: httpResponseWithPagination.data,
                meta: httpResponseWithPagination.meta,
              )),
            },
        (Failure failure) => {});
  }

  Future<void> onScrollPostSaved(
      ScrollBookmarkEvent event, Emitter emit) async {
    if (state.meta.currentPage < state.meta.totalPage ||
        state.meta.currentPage == 1) {
      print('my log scroll');
      emit(state.copyWith(isLoadMore: true));

      List<PostEntity> newPosts = [];
      GetWorkModel req = GetWorkModel(
        page: (state.meta.currentPage.toInt() + 1),
        pageSize: state.meta.pageSize.toInt(),
        search: '',
      );

      final result = await postUseCase.getPostsSaved(req);

      result.fold(
          (HttpResponseWithPagination<PostEntity> httpResponseWithPagination) =>
              {
                newPosts = [
                  ...state.posts.map((e) => PostEntity.fromJson(e.toJson())),
                  ...httpResponseWithPagination.data
                      .map((e) => PostEntity.fromJson(e.toJson()))
                ],
                emit(BookmarkState(
                    posts: newPosts,
                    meta: httpResponseWithPagination.meta,
                    isLoadMore: false)),
              },
          (Failure failure) => {});
    }
  }

  Future<void> onToggleBookmarkPostSaved(
      ToggleBookmarkEvent event, Emitter emit) async {
    final result = await postUseCase.toggleBookmark(event.id);
    result.fold(
        (HttpResponse httpResponse) => {
              emit(RemoveSuccessedBookmarkState()),
              add(InitBookmarkEvent()),
            },
        (Failure failure) => {});
  }
}
