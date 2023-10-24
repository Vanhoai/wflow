part of 'bloc.dart';

class HomeState extends Equatable {
  final List<PostEntity> recentJobs;
  final List<PostEntity> hotJobs;
  final List<CategoryEntity> categories;
  final String categorySelected;
  final bool isLoading;

  const HomeState({
    required this.recentJobs,
    required this.hotJobs,
    required this.categories,
    this.categorySelected = '',
    this.isLoading = false,
  });

  HomeState copyWith({
    List<PostEntity>? recentJobs,
    List<PostEntity>? hotJobs,
    List<CategoryEntity>? categories,
    String? categorySelected,
    bool? isLoading,
  }) {
    return HomeState(
      recentJobs: recentJobs ?? this.recentJobs,
      hotJobs: hotJobs ?? this.hotJobs,
      categories: categories ?? this.categories,
      categorySelected: categorySelected ?? this.categorySelected,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [recentJobs, hotJobs, categories, categorySelected, isLoading];
}
