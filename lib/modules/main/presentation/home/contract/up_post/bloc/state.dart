part of 'bloc.dart';

class UpPostState extends Equatable {
  final List<String> tasks;
  final List<CategoryEntity> skills;
  final List<CategoryEntity> categories;
  final List<CategoryEntity> skillSelected;
  final List<CategoryEntity> categorySelected;
  final bool isLoading;

  const UpPostState({
    required this.tasks,
    required this.skills,
    required this.categories,
    this.categorySelected = const [],
    this.skillSelected = const [],
    this.isLoading = false,
  });

  UpPostState copyWith({
    List<String>? tasks,
    List<CategoryEntity>? skills,
    List<CategoryEntity>? categories,
    List<CategoryEntity>? skillSelected,
    List<CategoryEntity>? categorySelected,
    bool? isLoading,
  }) {
    return UpPostState(
      tasks: tasks ?? this.tasks,
      skills: skills ?? this.skills,
      categories: categories ?? this.categories,
      skillSelected: skillSelected ?? this.skillSelected,
      categorySelected: categorySelected ?? this.categorySelected,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [tasks, skills, categories, skillSelected, categorySelected, isLoading];
}
