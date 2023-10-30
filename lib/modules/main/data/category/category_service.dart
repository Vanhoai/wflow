import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';

abstract class CategoryService {
  Future<List<CategoryEntity>> getSkillCategoryService();
  Future<List<CategoryEntity>> getPostCategoryService();
}

class CategoryServiceImpl implements CategoryService {
  final Agent agent;
  CategoryServiceImpl({required this.agent});

  @override
  Future<List<CategoryEntity>> getPostCategoryService() async {
    try {
      final response = await agent.dio.get('/category/posts');
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<CategoryEntity> categories = [];
      httpResponse.data.forEach((element) {
        categories.add(CategoryEntity.fromJson(element));
      });

      return categories;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<List<CategoryEntity>> getSkillCategoryService() async {
    try {
      final response = await agent.dio.get('/category/tags');
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<CategoryEntity> categories = [];
      httpResponse.data.forEach((element) {
        categories.add(CategoryEntity.fromJson(element));
      });

      return categories;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
