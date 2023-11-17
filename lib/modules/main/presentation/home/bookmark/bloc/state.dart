import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class BookmarkState extends Equatable {
  final List<PostEntity> posts;
  final Meta meta;
  final bool isLoadMore;

  const BookmarkState({
    this.posts = const [],
    this.meta =
        const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
    this.isLoadMore = false,
  });

  BookmarkState copyWith({
    List<PostEntity>? posts,
    Meta? meta,
    bool? isLoadMore,
  }) {
    return BookmarkState(
      posts: posts ?? this.posts,
      meta: meta ?? this.meta,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List get props => [posts, meta, isLoadMore];
}

class LoadMoreBookmarkState extends BookmarkState {}

class RemoveSuccessedBookmarkState extends LoadMoreBookmarkState {}
