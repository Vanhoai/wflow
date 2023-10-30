import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_repository.dart';

abstract class PostUseCase {
  Future<List<PostEntity>> getRecentJobs(String category);
  Future<List<PostEntity>> getHotJobs();
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request);
  Future<Either<PostEntity, Failure>> getPostId(String id);
  Future<List<PostEntity>> getSearchWorks(GetWorkModel getWorkModel);
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
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request) async {
    return await postRepository.getPostWithCategory(request);
  }

  @override
  @override
  Future<Either<PostEntity, Failure>> getPostId(String id) async {
    return await postRepository.getPostId(id);
  }

  @override
  Future<List<PostEntity>> getSearchWorks(GetWorkModel getWorkModel) async {
    return await postRepository.getSearchWorks(getWorkModel);
  }
}
