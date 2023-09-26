import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/modules/main/presentation/personal/file/bloc/file_event.dart';
import 'package:wflow/modules/main/presentation/personal/file/bloc/file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final PickFile pickFileInstance = PickFile();
  FileBloc() : super(const FileInitial()) {
    on<FilePickEvent>(pickFile);
    on<FilePickMultipleEvent>(pickMultipleFile);
    on<FileClearEvent>(clearFile);
    on<FileCancelEvent>(cancelFile);
  }

  FutureOr<void> pickFile(
    FileEvent event,
    Emitter<FileState> emit,
  ) async {
    clearFile(event, emit);
    await pickFileInstance.pickSingleFile(FileExtension.files);
    if (pickFileInstance.status == FilePickerStatus.picked) {
      emit(FileSuccessState(pickFileInstance.files));
    } else if (pickFileInstance.status == FilePickerStatus.cancel) {
      emit(FileCancelState(message: PickFile().error));
    } else {
      emit(FileFailureState(message: PickFile().error));
    }
  }

  FutureOr<void> pickMultipleFile(
    FileEvent event,
    Emitter<FileState> emit,
  ) async {
    clearFile(event, emit);
    await pickFileInstance.pickMultiFile(FileExtension.files);
    if (pickFileInstance.status == FilePickerStatus.picked) {
      emit(FileSuccessState(pickFileInstance.files));
    } else if (pickFileInstance.status == FilePickerStatus.cancel) {
      emit(FileCancelState(message: PickFile().error));
    } else {
      emit(FileFailureState(message: PickFile().error));
    }
  }

  FutureOr<void> clearFile(
    FileEvent event,
    Emitter<FileState> emit,
  ) async {
    emit(const FileInitial());
    await pickFileInstance.dispose();
  }

  FutureOr<void> cancelFile(
    FileEvent event,
    Emitter<FileState> emit,
  ) async {
    emit(const FileInitial());
    await pickFileInstance.dispose();
  }
}
