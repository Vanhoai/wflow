import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnSelectMultipleEvent extends PhotoEvent {
  final bool multiple;

  OnSelectMultipleEvent({required this.multiple});
  @override
  List<Object?> get props => [multiple];
}

class SelectPhotoEvent extends PhotoEvent {
  final AssetEntity entity;

  SelectPhotoEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class UnSelectPhotoEvent extends PhotoEvent {
  final AssetEntity entity;

  UnSelectPhotoEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class SendPhotoEvent extends PhotoEvent {
  final AssetEntity? entity;

  SendPhotoEvent({this.entity});

  @override
  List<Object?> get props => [entity];
}

class SendPhotoFromCameraEvent extends PhotoEvent {
  final File? file;

  SendPhotoFromCameraEvent({this.file});

  @override
  List<Object?> get props => [file];
}

class SendPhotosFromCameraEvent extends PhotoEvent {
  final List<File>? files;

  SendPhotosFromCameraEvent({this.files});

  @override
  List<Object?> get props => [files];
}
