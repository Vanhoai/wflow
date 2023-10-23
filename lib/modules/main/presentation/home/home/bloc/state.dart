part of 'bloc.dart';

class HomeState {
  final List<PostEntity> recentJobs;
  final List<PostEntity> hotJobs;
  final List<CategoryEntity> categories;
  final String categorySelected;

  HomeState({
    required this.recentJobs,
    required this.hotJobs,
    required this.categories,
    this.categorySelected = 'All',
  });

  HomeState copyWith({
    List<PostEntity>? recentJobs,
    List<PostEntity>? hotJobs,
    List<CategoryEntity>? categories,
    String? categorySelected,
  }) {
    return HomeState(
      recentJobs: recentJobs ?? this.recentJobs,
      hotJobs: hotJobs ?? this.hotJobs,
      categories: categories ?? this.categories,
      categorySelected: categorySelected ?? this.categorySelected,
    );
  }
}
