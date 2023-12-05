import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';

class SubTopicState extends Equatable {
  final List<CategoryEntity> categories;
  final List<CategoryEntity> categorySelected;

  const SubTopicState({
    this.categories = const [],
    this.categorySelected = const [],
  });

  SubTopicState copyWith({
    List<CategoryEntity>? categories,
    List<CategoryEntity>? categorySelected,
  }) =>
      SubTopicState(
        categories: categories ?? this.categories,
        categorySelected: categorySelected ?? this.categorySelected,
      );

  @override
  List get props => [categories, categorySelected];
}
