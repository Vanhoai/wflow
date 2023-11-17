import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

abstract class PostService {
  Future<List<PostEntity>> getRecentJob(String category);
  Future<List<PostEntity>> getHotJob();
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(
      GetPostWithCategory request);
  Future<PostEntity> getPostId(String id);
  Future<HttpResponseWithPagination<PostEntity>> getSearchWorks(
      GetWorkModel getWorkModel);
  Future<HttpResponseWithPagination<PostEntity>> getPostsSaved(
      GetWorkModel req);
  Future<HttpResponse> toggleBookmark(int id);
}

class PostServiceImpl implements PostService {
  final Agent agent;

  PostServiceImpl({required this.agent});

  @override
  Future<List<PostEntity>> getRecentJob(String category) async {
    try {
      final response =
          await agent.dio.get('/post/recent-jobs', queryParameters: {
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
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(
      GetPostWithCategory request) async {
    try {
      final response = await agent.dio.get(
        '/post/finds-by-category',
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'category': request.category,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponse =
          HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<PostEntity> posts =
          httpResponse.data.map((e) => PostEntity.fromJson(e)).toList();
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
  Future<HttpResponseWithPagination<PostEntity>> getSearchWorks(
      GetWorkModel getWorkModel) async {
    try {
      final response =
          await agent.dio.get('/post/find-and-filter', queryParameters: {
        'page': getWorkModel.page,
        'pageSize': getWorkModel.pageSize,
        'search': getWorkModel.search,
      });
      HttpResponseWithPagination<dynamic> httpResponseWithPagination =
          HttpResponseWithPagination.fromJson(response.data);

      if (httpResponseWithPagination.statusCode != 200) {
        throw ServerException(message: httpResponseWithPagination.message);
      }

      final posts = [
        ...httpResponseWithPagination.data.map((e) => PostEntity.fromJson(e))
      ];

      return HttpResponseWithPagination(
        statusCode: httpResponseWithPagination.statusCode,
        message: httpResponseWithPagination.message,
        meta: httpResponseWithPagination.meta,
        data: posts,
      );
    } catch (exception) {
      print('my log 2');
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<PostEntity>> getPostsSaved(
      GetWorkModel req) async {
    try {
      final response =
          await agent.dio.get('/post/find-post-bookmarked', queryParameters: {
        'page': req.page,
        'pageSize': req.pageSize,
        'search': req.search,
      });

      HttpResponseWithPagination<dynamic> httpResponseWithPagination =
          HttpResponseWithPagination.fromJson(response.data);

      if (httpResponseWithPagination.statusCode != 200) {
        throw ServerException(message: httpResponseWithPagination.message);
      }

      final posts = [
        ...httpResponseWithPagination.data.map((e) => PostEntity.fromJson(e))
      ];

      return HttpResponseWithPagination(
        statusCode: httpResponseWithPagination.statusCode,
        message: httpResponseWithPagination.message,
        meta: httpResponseWithPagination.meta,
        data: posts,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponse> toggleBookmark(int id) async {
    try {
      final response = await agent.dio.post('/bookmark/toggle/$id');

      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      return httpResponse;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
