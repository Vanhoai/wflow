import 'package:wflow/modules/main/data/category/category_service.dart';
import 'package:wflow/modules/main/domain/category/category_repository.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService categoryService;
  CategoryRepositoryImpl({required this.categoryService});

  @override
  Future<List<CategoryEntity>> getPostCategory() async {
    try {
      final categories = await categoryService.getPostCategoryService();
      return categories;
    } catch (exception) {
      return [];
    }
  }

  @override
  Future<List<CategoryEntity>> getSkillCategory() async {
    try {
      final categories = categoryService.getSkillCategoryService();
      return categories;
    } catch (exception) {
      return [];
    }
  }
}
