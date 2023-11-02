import 'package:wflow/modules/main/domain/category/category_repository.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';

abstract class CategoryUseCase {
  Future<List<CategoryEntity>> getSkillCategory();
  Future<List<CategoryEntity>> getPostCategory();
}

class CategoryUseCaseImpl implements CategoryUseCase {
  final CategoryRepository categoryRepository;
  CategoryUseCaseImpl({required this.categoryRepository});

  @override
  Future<List<CategoryEntity>> getSkillCategory() async {
    return await categoryRepository.getSkillCategory();
  }

  @override
  Future<List<CategoryEntity>> getPostCategory() async {
    return await categoryRepository.getPostCategory();
  }
}
