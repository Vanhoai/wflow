import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getSkillCategory();
  Future<List<CategoryEntity>> getPostCategory();
}
