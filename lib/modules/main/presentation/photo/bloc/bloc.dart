import 'dart:async';
import 'dart:io';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/event.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoState()) {
    on<OnSelectMultipleEvent>(onSelectMultiple);
    on<SelectPhotoEvent>(selectPhoto);
    on<UnSelectPhotoEvent>(unSelectPhoto);
    on<SendPhotoEvent>(sendPhoto);
    on<SendPhotoFromCameraEvent>(sendPhotoFromCamera);
  }

  FutureOr<void> onSelectMultiple(OnSelectMultipleEvent event, Emitter<PhotoState> emit) {
    if (event.multiple) {
      emit(PhotoMultipleState(entities: const []));
    } else {
      emit(PhotoSingleState(entity: null));
    }
  }

  FutureOr<void> selectPhoto(SelectPhotoEvent event, Emitter<PhotoState> emit) {
    if (state is PhotoSingleState) {
    } else if (state is PhotoMultipleState) {
      PhotoMultipleState newState = (state as PhotoMultipleState)
          .copyWith(entities: List.of((state as PhotoMultipleState).entities)..add(event.entity));
      emit(newState);
    } else {
      emit(state);
    }
  }

  FutureOr<void> unSelectPhoto(UnSelectPhotoEvent event, Emitter<PhotoState> emit) {
    if (state is PhotoMultipleState) {
      PhotoMultipleState newState = (state as PhotoMultipleState).copyWith(
          entities: List.of((state as PhotoMultipleState).entities)
            ..removeWhere((element) => element.id == event.entity.id));
      emit(newState);
    } else {
      emit(state);
    }
  }

  FutureOr<void> sendPhoto(SendPhotoEvent event, Emitter<PhotoState> emit) async {
    if (state is PhotoMultipleState) {
      List<File> photos = [];
      for (var element in (state as PhotoMultipleState).entities) {
        File? file = await element.file;
        if (file != null) {
          photos.add(file);
        }
      }
      emit(SendMultiplePhotoState(photoFile: photos));
    } else {
      File? file = await event.entity?.file;
      emit(SendSinglePhotoState(file: file!));
    }
  }

  FutureOr<void> sendPhotoFromCamera(SendPhotoFromCameraEvent event, Emitter<PhotoState> emit) {
    if (event.file != null) {
      emit(SendSinglePhotoState(file: event.file!));
    }
  }
}
