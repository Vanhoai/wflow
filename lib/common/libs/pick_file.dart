import 'dart:async';

import 'package:file_picker/file_picker.dart';

enum PickFileEnum {
  pickSingleFile,
  pickMultiFile,
}

enum FilePickerStatus {
  picked,
  cancel,
  error,
}

enum FileExtension {
  files,
  image,
  video,
  voice,
}

class PickFile {
  late List<PlatformFile> files = [];
  late FilePickerStatus status;
  late String error;

  PickFile();

  // Config dialog pick file
  static const String titlePickSingleFile = 'Pick excel file';
  static const String titlePickMultiFile = 'Pick multiple files';
  static const String titlePickImage = 'Pick image';
  static const String titlePickVideo = 'Pick video';
  static const String titlePickVoice = 'Pick voice';

  // Error
  static const String errorPickSingleFile = 'Error pick file';
  static const String errorPickMultiFile = 'Error pick files';
  static const String permissionDenied = 'Permission denied';
  static const String noFilesSelected = 'No files selected';

  static const List<String> allowedExtensionsFiles = [
    'xlsx',
    'xlsm',
    'doc',
    'xls',
    'xlsb',
    'xltx',
    'xltm',
    'xls',
    'xlt',
    'xml',
    'xlam',
    'xla',
    'xlw',
    'xlr',
    'docx',
    'docm',
    'ppt',
    'pptx',
    'pdf',
    'txt',
    'csv',
    'json',
    'zip',
    'rar',
    '7z',
    'tar',
    'gz',
    'tgz',
    'bz2',
    'tbz2',
  ];

  static const List<String> allowedExtensionsImage = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'webp',
    'tiff',
    'psd',
    'raw',
    'heif',
    'pdf',
  ];

  static const List<String> allowedExtensionsVideo = [
    'mp4',
    'avi',
    'mov',
    'wmv',
    'flv',
    'webm',
    'mkv',
    'm4v',
    '3gp',
    'mpg',
    'mpeg',
    'm2v',
    'm4p',
    'm4b',
    'm4r',
    'm4a',
    'mp3',
    'wav',
    'wma',
    'aac',
    'ogg',
    'oga',
    'flac',
    'alac',
    'aiff',
    'aif',
    'amr',
    'opus',
    'spx',
    'oga',
    'ogv',
    'ogx',
    'spx',
  ];

  static const List<String> allowedExtensionsVoice = [
    'mp3',
    'wav',
    'wma',
    'aac',
    'ogg',
    'oga',
    'flac',
    'alac',
    'aiff',
    'aif',
    'amr',
    'opus',
    'spx',
    'oga',
    'ogv',
    'ogx',
    'spx',
  ];

  FutureOr<void> pickSingleFile(FileExtension extension) async {
    dispose();
    try {
      final FilePickerResult? currentFile = await FilePicker.platform
          .pickFiles(
        type: FileType.custom,
        allowedExtensions: extension == FileExtension.files
            ? allowedExtensionsFiles
            : extension == FileExtension.image
                ? allowedExtensionsImage
                : extension == FileExtension.video
                    ? allowedExtensionsVideo
                    : allowedExtensionsVoice,
        dialogTitle: extension == FileExtension.files
            ? titlePickSingleFile
            : extension == FileExtension.image
                ? titlePickImage
                : extension == FileExtension.video
                    ? titlePickVideo
                    : titlePickVoice,
      )
          .then((value) {
        if (value != null) {
          status = FilePickerStatus.picked;
          return value;
        } else if (value == null) {
          status = FilePickerStatus.cancel;
        } else {
          status = FilePickerStatus.error;
        }
        return value;
      });

      switch (status) {
        case FilePickerStatus.picked:
          if (currentFile != null &&
              currentFile.files.isNotEmpty &&
              currentFile.files.every((element) => element.path != null)) {
            files.addAll(currentFile.files);
          }
          break;
        case FilePickerStatus.cancel:
          error = noFilesSelected;
          break;
        case FilePickerStatus.error:
          error = errorPickSingleFile;
          break;
        default:
          error = errorPickSingleFile;
          break;
      }
    } catch (e) {
      error = e.toString();
      print(e);
    }
  }

  FutureOr<void> pickMultiFile(FileExtension extension) async {
    dispose();
    try {
      final FilePickerResult? currentFile = await FilePicker.platform
          .pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: extension == FileExtension.files
            ? allowedExtensionsFiles
            : extension == FileExtension.image
                ? allowedExtensionsImage
                : extension == FileExtension.video
                    ? allowedExtensionsVideo
                    : allowedExtensionsVoice,
        dialogTitle: extension == FileExtension.files
            ? titlePickMultiFile
            : extension == FileExtension.image
                ? titlePickImage
                : extension == FileExtension.video
                    ? titlePickVideo
                    : titlePickVoice,
      )
          .then((value) {
        if (value != null) {
          status = FilePickerStatus.picked;
          return value;
        } else if (value == null) {
          status = FilePickerStatus.cancel;
        } else {
          status = FilePickerStatus.error;
        }
        return value;
      });

      switch (status) {
        case FilePickerStatus.picked:
          if (currentFile != null &&
              currentFile.files.isNotEmpty &&
              currentFile.files.every((element) => element.path != null)) {
            files.addAll(currentFile.files);
          }
          break;
        case FilePickerStatus.cancel:
          error = noFilesSelected;
          break;
        case FilePickerStatus.error:
          error = errorPickMultiFile;
          break;
        default:
          error = errorPickMultiFile;
          break;
      }
    } catch (e) {
      error = e.toString();
      print(e);
    }
  }

  Future<void> getFiles(PickFileEnum pickFileEnum, FileExtension extension) async {
    switch (pickFileEnum) {
      case PickFileEnum.pickSingleFile:
        await pickSingleFile(extension);
        break;
      case PickFileEnum.pickMultiFile:
        await pickMultiFile(extension);
        break;
      default:
        await pickSingleFile(extension);
        break;
    }
  }

  Future<String> getError() async {
    return error;
  }

  Future<void> dispose() async {
    try {
      files.clear();
      error = '';
    } catch (e) {
      error = e.toString();
      print(e);
    }
  }
}
