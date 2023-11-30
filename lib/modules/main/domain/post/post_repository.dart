import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/post/models/request/get_post_with_category.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/data/post/models/request/up_post_rqst.dart';
import 'package:wflow/modules/main/domain/post/entities/graph_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getRecentJobs(String category);
  Future<List<PostEntity>> getHotJobs();
  Future<HttpResponseWithPagination<PostEntity>> getPostWithCategory(GetPostWithCategory request);
  Future<Either<PostEntity, Failure>> getPostId(String id);
  Future<Either<HttpResponseWithPagination<PostEntity>, Failure>> getSearchWorks(GetWorkModel getWorkModel);
  Future<Either<HttpResponseWithPagination<PostEntity>, Failure>> getPostsSaved(GetWorkModel req);
  Future<Either<HttpResponse, Failure>> toggleBookmark(int id);
  Future<Either<String, Failure>> upPost({required UpPostRequest request});
  Future<List<GraphEntity>> getStatistic();
}
