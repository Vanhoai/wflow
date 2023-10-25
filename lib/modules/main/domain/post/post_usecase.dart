import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_repository.dart';

abstract class PostUseCase {
  Future<List<PostEntity>> getRecentJobs(String category);
  Future<List<PostEntity>> getHotJobs();
  Future<List<CategoryEntity>> getPostCategories();
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request);
}

class PostUseCaseImpl implements PostUseCase {
  final PostRepository postRepository;

  PostUseCaseImpl({required this.postRepository});

  @override
  Future<List<PostEntity>> getHotJobs() async {
    return await postRepository.getHotJobs();
  }

  @override
  Future<List<PostEntity>> getRecentJobs(String category) async {
    return await postRepository.getRecentJobs(category);
  }

  @override
  Future<List<CategoryEntity>> getPostCategories() async {
    return await postRepository.getPostCategories();
  }

  @override
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request) async {
    return await postRepository.getPostWithCategory(request);
  }
}
