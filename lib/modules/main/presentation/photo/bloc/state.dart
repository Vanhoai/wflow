




import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoState extends Equatable {
  @override
  List<Object?> get props => [];
}


class PhotoMultipleState extends PhotoState {

  final List<AssetEntity> entities;
  PhotoMultipleState({required this.entities});

  PhotoMultipleState copyWith({
    List<AssetEntity>? entities
}) {
    return PhotoMultipleState(entities: entities ?? this.entities);
  }


  @override
  List<Object?> get props => [entities];
}
class PhotoSingleState extends PhotoState {

  final AssetEntity? entity;
  PhotoSingleState({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class SendMultiplePhotoState extends PhotoState{
  final List<File> photoFile;
  SendMultiplePhotoState({required this.photoFile});
  @override
  List<Object?> get props => [photoFile];
}

class SendSinglePhotoState extends PhotoState{

}