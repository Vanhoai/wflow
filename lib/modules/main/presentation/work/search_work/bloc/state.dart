import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class SearchWorkState extends Equatable {
  final List<PostEntity> postsData;
  final bool isHiddenSuffixIcon;
  final String txtSearch;
  final bool isLoadMore;
  final Meta meta;
  final List<bool> bookmarks;

  const SearchWorkState({
    this.postsData = const [],
    this.isHiddenSuffixIcon = true,
    this.txtSearch = '',
    this.isLoadMore = false,
    this.meta =
        const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
    this.bookmarks = const [],
  });

  SearchWorkState copyWith({
    List<PostEntity>? postsData,
    bool? isHiddenSuffixIcon,
    String? txtSearch,
    bool? isLoadMore,
    Meta? meta,
    List<bool>? bookmarks,
  }) {
    return SearchWorkState(
      postsData: postsData ?? this.postsData,
      isHiddenSuffixIcon: isHiddenSuffixIcon ?? this.isHiddenSuffixIcon,
      txtSearch: txtSearch ?? this.txtSearch,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      meta: meta ?? this.meta,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }

  @override
  List<Object?> get props => [
        postsData,
        isHiddenSuffixIcon,
        txtSearch,
        isLoadMore,
        meta,
        bookmarks,
      ];
}

class LoadMoreSearchWorkState extends SearchWorkState {}

class GetSuccessedSearchWorkState extends SearchWorkState {}
