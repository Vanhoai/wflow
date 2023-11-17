import 'package:dio/dio.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/media/models/upload_file_rqst.dart';
import 'package:wflow/modules/main/domain/media/entities/file_entity.dart';

abstract class MediaService {
  Future<FileEntity> uploadFile({required UploadFileRequest request});
}

class MediaPaths {
  static const String uploadFile = '/file/upload';
}

class MediaServiceImpl implements MediaService {
  final Agent agent;
  MediaServiceImpl({required this.agent});

  @override
  Future<FileEntity> uploadFile({required UploadFileRequest request}) async {
    try {
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(request.file.path),
        'folder': request.folder,
      });

      final response = await agent.dio.post(MediaPaths.uploadFile, data: formData);
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return FileEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }
}
