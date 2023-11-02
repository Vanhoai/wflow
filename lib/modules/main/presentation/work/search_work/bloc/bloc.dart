import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/state.dart';

class SearchWorkBloc extends Bloc<SearchWorkEvent, SearchWorkState> {
  final PostUseCase postUseCase;
  final int defaultPage = 1;
  final int defaultPageSize = 3;
  final String defaultSearch = '';

  SearchWorkBloc({required this.postUseCase}) : super(const SearchWorkState()) {
    on<InitSearchWorkEvent>(onInitSearchWork);
    on<ChangedSearchWorkEvent>(onChangedSearchWork);
    on<ChangedIconClearSearchWorkEvent>(onChangedIconClearSearchWork);
    on<ScrollSearchWorkEvent>(onScrollSearchWork);
  }

  Future<void> onInitSearchWork(InitSearchWorkEvent event, Emitter emit) async {
    GetWorkModel getWorkModel = GetWorkModel(
        page: defaultPage, pageSize: defaultPageSize, search: defaultSearch);
    final List<PostEntity> posts =
        await postUseCase.getSearchWorks(getWorkModel);

    emit(state.coppyWith(postsData: posts));
  }

  Future<void> onChangedSearchWork(
      ChangedSearchWorkEvent event, Emitter emit) async {
    GetWorkModel getWorkModel = GetWorkModel(
        page: defaultPage, pageSize: defaultPageSize, search: event.txtSearch);
    final List<PostEntity> posts =
        await postUseCase.getSearchWorks(getWorkModel);

    emit(state.coppyWith(postsData: posts, txtSearch: event.txtSearch));
  }

  Future<void> onChangedIconClearSearchWork(
      ChangedIconClearSearchWorkEvent event, Emitter emit) async {
    emit(state.coppyWith(
        isHiddenSuffixIcon: event.txtSearch == '', txtSearch: event.txtSearch));
  }

  Future<void> onScrollSearchWork(
      ScrollSearchWorkEvent event, Emitter emit) async {
    GetWorkModel getWorkModel = GetWorkModel(
      page: state.page + 1,
      pageSize: defaultPageSize,
      search: state.txtSearch,
    );
    final List<PostEntity> posts =
        await postUseCase.getSearchWorks(getWorkModel);

    final List<PostEntity> newPosts = [
      ...state.postsData.map((e) => PostEntity(
          id: e.id,
          updatedAt: e.updatedAt,
          position: e.position,
          title: e.title,
          content: e.content,
          duration: e.duration,
          salary: e.salary,
          creatorId: e.creatorId,
          creatorName: e.creatorName,
          creatorAvatar: e.creatorAvatar,
          companyName: e.companyName,
          companyLogo: e.companyLogo,
          skills: e.skills,
          tasks: e.tasks)),
      ...posts.map((e) => PostEntity(
          id: e.id,
          updatedAt: e.updatedAt,
          position: e.position,
          title: e.title,
          content: e.content,
          duration: e.duration,
          salary: e.salary,
          creatorId: e.creatorId,
          creatorName: e.creatorName,
          creatorAvatar: e.creatorAvatar,
          companyName: e.companyName,
          companyLogo: e.companyLogo,
          skills: e.skills,
          tasks: e.tasks)),
    ];

    emit(state.coppyWith(postsData: newPosts));
  }
}
