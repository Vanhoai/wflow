import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class BookmarkState extends Equatable {
  final List<PostEntity> posts;
  final Meta meta;

  const BookmarkState({
    this.posts = const [],
    this.meta =
        const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
  });

  BookmarkState copyWith({List<PostEntity>? posts, Meta? meta}) {
    return BookmarkState(
      posts: posts ?? this.posts,
      meta: meta ?? this.meta,
    );
  }

  @override
  List get props => [posts, meta];
}

class LoadMoreBookmarkState extends BookmarkState {}

class RemoveSuccessedBookmarkState extends LoadMoreBookmarkState {}
