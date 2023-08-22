import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

sealed class FileState extends Equatable {
  const FileState({
    this.message = '',
    this.files = const [],
  });

  final String message;
  final List<PlatformFile> files;

  static const String messageEmpty = 'No file selected';
  static const String messageCancel = 'File selection canceled';
  static const String messageClear = 'File selection cleared';

  @override
  List<Object> get props => [];
}

final class FileInitial extends FileState {
  const FileInitial();

  @override
  List<Object> get props => [];
}

class FileSuccessState extends FileState {
  const FileSuccessState(List<PlatformFile> files) : super(files: files);

  @override
  List<Object> get props => [files];
}

class FileFailureState extends FileState {
  const FileFailureState({String message = FileState.messageEmpty}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class FileCancelState extends FileState {
  const FileCancelState({String message = FileState.messageCancel}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class FileClearState extends FileState {
  const FileClearState({String message = FileState.messageClear}) : super(message: message, files: const []);

  @override
  List<Object> get props => [message, files];
}
