part of 'bloc.dart';

class WorkState extends Equatable {
  final List<CategoryEntity> categories;
  final List<PostEntity> posts;
  final Meta meta;
  final String categorySelected;
  final String messageNotification;
  final bool isLoading;
  final bool isLoadMore;
  final bool isFinal;

  const WorkState({
    required this.categories,
    required this.posts,
    this.categorySelected = 'All',
    this.meta = const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
    this.messageNotification = '',
    this.isLoading = false,
    this.isLoadMore = false,
    this.isFinal = false,
  });

  WorkState copyWith({
    List<CategoryEntity>? categories,
    List<PostEntity>? posts,
    Meta? meta,
    String? categorySelected,
    String? messageNotification,
    bool? isLoading,
    bool? isLoadMore,
    bool? isFinal,
  }) {
    return WorkState(
      categories: categories ?? this.categories,
      posts: posts ?? this.posts,
      meta: meta ?? this.meta,
      categorySelected: categorySelected ?? this.categorySelected,
      messageNotification: messageNotification ?? this.messageNotification,
      isLoading: isLoading ?? this.isLoading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      isFinal: isFinal ?? this.isFinal,
    );
  }

  @override
  List<Object> get props =>
      [categories, categorySelected, meta, posts, messageNotification, isLoading, isLoadMore, isFinal];
}
