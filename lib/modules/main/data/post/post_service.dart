import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

abstract class PostService {
  Future<List<PostEntity>> getRecentJob(String category);
  Future<List<PostEntity>> getHotJob();
  Future<List<CategoryEntity>> getPostCategories();
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request);
  Future<PostEntity> getPostId(String id);
  Future<List<PostEntity>> getSearchWorks(GetWorkModel getWorkModel);
}

class PostServiceImpl implements PostService {
  final Agent agent;

  PostServiceImpl({required this.agent});

  @override
  Future<List<PostEntity>> getRecentJob(String category) async {
    try {
      final response = await agent.dio.get('/post/recent-jobs', queryParameters: {
        'category': category,
      });
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<PostEntity> posts = [];
      httpResponse.data.forEach((element) {
        posts.add(PostEntity.fromJson(element));
      });

      return posts;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<List<PostEntity>> getHotJob() async {
    try {
      final response = await agent.dio.get('/post/hot-jobs');
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<PostEntity> posts = [];
      httpResponse.data.forEach((element) {
        posts.add(PostEntity.fromJson(element));
      });

      return posts;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<List<CategoryEntity>> getPostCategories() async {
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
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request) async {
    try {
      final response = await agent.dio.get(
        '/post/finds-by-category',
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'category': request.category,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponse = HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<PostEntity> posts = httpResponse.data.map((e) => PostEntity.fromJson(e)).toList();
      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: posts,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<PostEntity> getPostId(String id) async {
    try {
      final response = await agent.dio.get(
        '/post/find/$id',
      );
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }
      return PostEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<List<PostEntity>> getSearchWorks(GetWorkModel getWorkModel) async {
    try {
      final response = await agent.dio.get(
          '/post/find-and-filter?page=${getWorkModel.page}&pageSize=${getWorkModel.pageSize}&search=${getWorkModel.search}');
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<PostEntity> posts = [];
      httpResponse.data.forEach((post) {
        posts.add(PostEntity.fromJson(post));
      });

      return posts;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
