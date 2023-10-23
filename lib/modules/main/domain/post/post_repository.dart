import 'package:dartz/dartz.dart';
import 'package:wflow/core/entities/category/category_entity.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getRecentJobs();
  Future<List<PostEntity>> getHotJobs();
  Future<List<CategoryEntity>> getPostCategories();
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(
      GetPostWithCategory request);
  Future<Either<PostEntity, Failure>> getPostId(String id);
}
