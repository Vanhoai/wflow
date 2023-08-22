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

class PickFile {
  late List<PlatformFile> files = [];
  late FilePickerStatus status;
  late String error;

  PickFile();

  // Config dialog pick file
  static const String titlePickSingleFile = 'Pick excel file';
  static const String titlePickMultiFile = 'Pick excel files';

  // Error
  static const String errorPickSingleFile = 'Error pick file';
  static const String errorPickMultiFile = 'Error pick files';
  static const String permissionDenied = 'Permission denied';
  static const String noFilesSelected = 'No files selected';

  static const List<String> allowedExtensions = [
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
    'xlr'
  ];

  FutureOr<void> pickSingleFile() async {
    clearError();
    try {
      final FilePickerResult? currentFile = await FilePicker.platform
          .pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
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

  FutureOr<void> pickMultiFile() async {
    clearError();
    try {
      final FilePickerResult? currentFile = await FilePicker.platform
          .pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: allowedExtensions,
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

  FutureOr<void> clearError() async {
    try {
      error = '';
    } catch (e) {
      error = e.toString();
      print(e);
    }
  }

  FutureOr<void> clearFile() async {
    try {
      files.clear();
    } catch (e) {
      error = e.toString();
      print(e);
    }
  }
}
