import 'dart:io';

class UploadFileRequest {
  final String folder;
  final File file;

  UploadFileRequest({
    required this.folder,
    required this.file,
  });
}
