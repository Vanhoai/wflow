import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/state.dart';

class SearchWorkBloc extends Bloc<SearchWorkEvent, SearchWorkState> {
  final PostUseCase postUseCase;

  SearchWorkBloc({required this.postUseCase}) : super(const SearchWorkState()) {
    on<InitSearchWorkEvent>(onInitSearchWork);
    on<ChangedSearchWorkEvent>(onChangedSearchWork);
    on<ScrollSearchWorkEvent>(onScrollSearchWork);
    on<RefreshSearchWorkEvent>(onRefreshSearchWork);
    on<ChangedIconClearSearchWorkEvent>(onChangedIconClearSearchWorkEvent);
    on<ToggleBookmarkSearchWorkEvent>(onToggleBookmarkSearchWorkEvent);
  }

  Future<void> onInitSearchWork(InitSearchWorkEvent event, Emitter emit) async {
    List<bool> bookmarks = [];
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    GetWorkModel getWorkModel = GetWorkModel(
      page: state.meta.currentPage.toInt(),
      pageSize: state.meta.pageSize.toInt(),
      search: '',
    );
    final result = await postUseCase.getSearchWorks(getWorkModel);

    result.fold(
        (HttpResponseWithPagination<PostEntity> httpResponseWithPagination) => {
              bookmarks = [
                ...httpResponseWithPagination.data.map((e) => e.isBookmark)
              ],
              emit(state.copyWith(
                meta: httpResponseWithPagination.meta,
                postsData: httpResponseWithPagination.data,
                bookmarks: bookmarks,
              )),
            },
        (Failure failure) => {});
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onChangedSearchWork(
      ChangedSearchWorkEvent event, Emitter emit) async {
    List<bool> bookmarks = [];
    GetWorkModel getWorkModel = GetWorkModel(
      page: 1,
      pageSize: 10,
      search: event.txtSearch,
    );
    final result = await postUseCase.getSearchWorks(getWorkModel);

    result.fold(
        (HttpResponseWithPagination<PostEntity> httpResponseWithPagination) => {
              bookmarks = [
                ...httpResponseWithPagination.data.map((e) => e.isBookmark)
              ],
              emit(state.copyWith(
                txtSearch: event.txtSearch,
                meta: httpResponseWithPagination.meta,
                postsData: httpResponseWithPagination.data,
                bookmarks: bookmarks,
              )),
            },
        (Failure failure) => {});
  }

  Future<void> onScrollSearchWork(
      ScrollSearchWorkEvent event, Emitter emit) async {
    if (state.meta.currentPage < state.meta.totalPage ||
        state.meta.currentPage == 1) {
      List<bool> bookmarks = [];
      emit(state.copyWith(isLoadMore: true));
      List<PostEntity> newPosts = [];
      GetWorkModel getWorkModel = GetWorkModel(
        page: state.meta.currentPage.toInt() + 2,
        pageSize: state.meta.pageSize.toInt(),
        search: state.txtSearch,
      );
      final result = await postUseCase.getSearchWorks(getWorkModel);
      result.fold(
          (HttpResponseWithPagination<PostEntity> httpResponseWithPagination) =>
              {
                bookmarks = [
                  ...state.bookmarks,
                  ...httpResponseWithPagination.data.map((e) => e.isBookmark)
                ],
                newPosts = [
                  ...state.postsData
                      .map((e) => PostEntity.fromJson(e.toJson())),
                  ...httpResponseWithPagination.data
                      .map((e) => PostEntity.fromJson(e.toJson()))
                ],
                emit(state.copyWith(
                  isLoadMore: false,
                  meta: httpResponseWithPagination.meta,
                  postsData: newPosts,
                  bookmarks: bookmarks,
                )),
              },
          (Failure failure) => {
                print('my log 1'),
              });
    }
  }

  Future<void> onRefreshSearchWork(
      RefreshSearchWorkEvent event, Emitter emit) async {
    List<bool> bookmarks = [];
    GetWorkModel getWorkModel = GetWorkModel(
      page: 1,
      pageSize: 10,
      search: state.txtSearch,
    );
    final result = await postUseCase.getSearchWorks(getWorkModel);

    result.fold(
        (HttpResponseWithPagination<PostEntity> httpResponseWithPagination) => {
              bookmarks = [
                ...httpResponseWithPagination.data.map((e) => e.isBookmark)
              ],
              emit(state.copyWith(
                postsData: httpResponseWithPagination.data,
                meta: httpResponseWithPagination.meta,
                bookmarks: bookmarks,
              )),
            },
        (Failure failure) => {});
  }

  Future<void> onChangedIconClearSearchWorkEvent(
      ChangedIconClearSearchWorkEvent event, Emitter emit) async {
    emit(state.copyWith(isHiddenSuffixIcon: event.txtSearch.isEmpty));
  }

  Future<void> onToggleBookmarkSearchWorkEvent(
      ToggleBookmarkSearchWorkEvent event, Emitter emit) async {
    instance.get<BookmarkBloc>().add(ToggleBookmarkEvent(id: event.id));

    List<bool> newBookmarks = [...state.bookmarks];
    newBookmarks[event.index] = event.isBookmarked;
    emit(state.copyWith(bookmarks: newBookmarks));
  }
}
