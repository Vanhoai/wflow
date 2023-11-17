part of 'bloc.dart';

class HomeState extends Equatable {
  final List<PostEntity> recentJobs;
  final List<PostEntity> hotJobs;
  final List<CategoryEntity> categories;
  final String categorySelected;
  final bool isLoading;
  final bool loadingCategory;
  final List<bool> bookmarks;
  final List<bool> bookmarksRecent;

  const HomeState({
    required this.recentJobs,
    required this.hotJobs,
    required this.categories,
    this.categorySelected = '',
    this.isLoading = false,
    this.loadingCategory = false,
    this.bookmarks = const [],
    this.bookmarksRecent = const [],
  });

  HomeState copyWith({
    List<PostEntity>? recentJobs,
    List<PostEntity>? hotJobs,
    List<CategoryEntity>? categories,
    String? categorySelected,
    bool? isLoading,
    bool? loadingCategory,
    List<bool>? bookmarks,
    List<bool>? bookmarksRecent,
  }) {
    return HomeState(
      recentJobs: recentJobs ?? this.recentJobs,
      hotJobs: hotJobs ?? this.hotJobs,
      categories: categories ?? this.categories,
      categorySelected: categorySelected ?? this.categorySelected,
      isLoading: isLoading ?? this.isLoading,
      loadingCategory: loadingCategory ?? this.loadingCategory,
      bookmarks: bookmarks ?? this.bookmarks,
      bookmarksRecent: bookmarksRecent ?? this.bookmarksRecent,
    );
  }

  @override
  List<Object?> get props => [
        recentJobs,
        hotJobs,
        categories,
        categorySelected,
        isLoading,
        loadingCategory,
        bookmarks,
        bookmarksRecent,
      ];
}
