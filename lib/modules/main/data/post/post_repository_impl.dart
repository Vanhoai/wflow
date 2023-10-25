import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
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
  Future<List<PostEntity>> getRecentJobs(String category) async {
    try {
      final posts = await postService.getRecentJob(category);
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
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request) async {
    try {
      final response = await postService.getPostWithCategory(request);
      return response;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }
}
