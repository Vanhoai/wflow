import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/media/models/upload_file_rqst.dart';
import 'package:wflow/modules/main/domain/media/entities/file_entity.dart';

abstract class MediaRepository {
  Future<Either<FileEntity, Failure>> uploadFile({required UploadFileRequest request});
}
