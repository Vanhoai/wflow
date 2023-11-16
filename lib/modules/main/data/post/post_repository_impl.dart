import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
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
  Future<List<PostEntity>> getRecentJobs(String category) async {
    try {
      final posts = await postService.getRecentJob(category);
      return posts;
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
  Future<Either<PostEntity, Failure>> getPostId(String id) async {
    try {
      final posts = await postService.getPostId(id);
      return Left(posts);
    } catch (exception) {
      return const Right(ServerFailure());
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

  @override
  Future<Either<HttpResponseWithPagination<PostEntity>, Failure>> getPostsSaved(
      GetWorkModel req) async {
    try {
      final posts = await postService.getPostsSaved(req);
      return Left(posts);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }

  @override
  Future<Either<HttpResponse, Failure>> toggleBookmark(int id) async {
    try {
      final res = await postService.toggleBookmark(id);

      return Left(res);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
}
