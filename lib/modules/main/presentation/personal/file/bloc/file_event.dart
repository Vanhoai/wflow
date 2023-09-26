import 'package:equatable/equatable.dart';

sealed class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

class FilePickEvent extends FileEvent {
  const FilePickEvent();
}

class FilePickMultipleEvent extends FileEvent {
  const FilePickMultipleEvent();
}

class FileClearEvent extends FileEvent {
  const FileClearEvent();
}

class FileCancelEvent extends FileEvent {
  const FileCancelEvent();
}

class FileSuccessEvent extends FileEvent {
  const FileSuccessEvent();
}

class FileFailureEvent extends FileEvent {
  const FileFailureEvent();
}
