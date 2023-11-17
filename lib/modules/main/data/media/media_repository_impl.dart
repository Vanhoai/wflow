import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/media/media_service.dart';
import 'package:wflow/modules/main/data/media/models/upload_file_rqst.dart';
import 'package:wflow/modules/main/domain/media/entities/file_entity.dart';
import 'package:wflow/modules/main/domain/media/media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaService mediaService;
  const MediaRepositoryImpl({required this.mediaService});

  @override
  Future<Either<FileEntity, Failure>> uploadFile({required UploadFileRequest request}) async {
    try {
      final response = await mediaService.uploadFile(request: request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
}
