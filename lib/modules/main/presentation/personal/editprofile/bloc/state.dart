import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class EditProfileState extends Equatable {
  final UserEntity userEntity;
  final File? avatar;
  final File? background;
  const EditProfileState({required this.userEntity, required this.avatar, required this.background});

  EditProfileState copyWith({UserEntity? userEntity, File? avatar, File? background}) {
    return EditProfileState(
        avatar: avatar ?? this.avatar,
        background: background ?? this.background,
        userEntity: userEntity ?? this.userEntity);
  }

  @override
  List<Object?> get props => [userEntity, avatar, background];
}
