import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/media/models/upload_file_rqst.dart';
import 'package:wflow/modules/main/domain/media/entities/file_entity.dart';
import 'package:wflow/modules/main/domain/media/media_repository.dart';

abstract class MediaUseCase {
  Future<Either<FileEntity, Failure>> uploadFile({required UploadFileRequest request});
}

class MediaUseCaseImpl implements MediaUseCase {
  final MediaRepository mediaRepository;
  MediaUseCaseImpl({required this.mediaRepository});

  @override
  Future<Either<FileEntity, Failure>> uploadFile({required UploadFileRequest request}) async {
    return mediaRepository.uploadFile(request: request);
  }
}
