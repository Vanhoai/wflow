import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/data/post/post_service.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService postService;
  PostRepositoryImpl({required this.postService});

  @override
  Future<List<PostEntity>> getHotJobs() async {
    try {
      final posts = await postService.getHotJob();
      return posts;
    } catch (exception) {
      return [];
    }
  }

  @override
  Future<List<PostEntity>> getRecentJobs() async {
    try {
      final posts = await postService.getRecentJob();
      return posts;
    } catch (exception) {
      return [];
    }
  }

  @override
  Future<List<CategoryEntity>> getPostCategories() async {
    try {
      final categories = await postService.getPostCategories();
      return categories;
    } catch (exception) {
      return [];
    }
  }

  @override
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(
      GetPostWithCategory request) async {
    try {
      final response = await postService.getPostWithCategory(request);
      return response;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }

  @override
  Future<List<PostEntity>> getSearchWorks(GetWorkModel getWorkModel) async {
    try {
      final posts = await postService.getSearchWorks(getWorkModel);
      return posts;
    } catch (exception) {
      return [];
    }
  }
}
