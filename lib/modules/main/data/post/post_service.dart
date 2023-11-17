import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/data/post/models/request/up_post_rqst.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class PostPaths {
  static const String recentJobs = '/post/recent-jobs';
  static const String hotJobs = '/post/hot-jobs';
  static const String findPostByCategory = '/post/finds-by-category';
  static String findPostById(String id) => '/post/find/$id';
  static const String findAndFilter = '/post/find-and-filter';
  static const String findPostBookmarked = '/post/find-post-bookmarked';
  static String toggleBookmark(int id) => '/bookmark/toggle/$id';
  static const String upPost = '/post/create';
}

abstract class PostService {
  Future<List<PostEntity>> getRecentJob(String category);
  Future<List<PostEntity>> getHotJob();
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request);
  Future<PostEntity> getPostId(String id);
  Future<HttpResponseWithPagination<PostEntity>> getSearchWorks(GetWorkModel getWorkModel);
  Future<HttpResponseWithPagination<PostEntity>> getPostsSaved(GetWorkModel request);
  Future<HttpResponse> toggleBookmark(int id);
  Future<String> upPost({required UpPostRequest request});
}

class PostServiceImpl implements PostService {
  final Agent agent;

  PostServiceImpl({required this.agent});

  @override
  Future<List<PostEntity>> getRecentJob(String category) async {
    try {
      final response = await agent.dio.get(
        PostPaths.recentJobs,
        queryParameters: {
          'category': category,
        },
      );
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
      final response = await agent.dio.get(PostPaths.hotJobs);
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
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request) async {
    try {
      final response = await agent.dio.get(
        PostPaths.findPostByCategory,
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
        PostPaths.findPostById(id),
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
  Future<HttpResponseWithPagination<PostEntity>> getSearchWorks(GetWorkModel getWorkModel) async {
    try {
      final response = await agent.dio.get(
        PostPaths.findAndFilter,
        queryParameters: {
          'page': getWorkModel.page,
          'pageSize': getWorkModel.pageSize,
          'search': getWorkModel.search,
        },
      );
      HttpResponseWithPagination<dynamic> httpResponseWithPagination =
          HttpResponseWithPagination.fromJson(response.data);

      if (httpResponseWithPagination.statusCode != 200) {
        throw ServerException(message: httpResponseWithPagination.message);
      }

      final posts = [...httpResponseWithPagination.data.map((e) => PostEntity.fromJson(e))];

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
  Future<HttpResponseWithPagination<PostEntity>> getPostsSaved(GetWorkModel req) async {
    try {
      final response = await agent.dio.get(
        PostPaths.findPostBookmarked,
        queryParameters: {
          'page': req.page,
          'pageSize': req.pageSize,
          'search': req.search,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponseWithPagination =
          HttpResponseWithPagination.fromJson(response.data);

      if (httpResponseWithPagination.statusCode != 200) {
        throw ServerException(message: httpResponseWithPagination.message);
      }

      final posts = [...httpResponseWithPagination.data.map((e) => PostEntity.fromJson(e))];

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
      final response = await agent.dio.post(
        PostPaths.toggleBookmark(id),
      );

      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      return httpResponse;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> upPost({required UpPostRequest request}) async {
    try {
      final response = await agent.dio.post(
        PostPaths.upPost,
        data: request.toJson(),
      );

      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.message;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
