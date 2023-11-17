import 'dart:io';

import 'package:equatable/equatable.dart';

class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProfile extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

class EditProfile extends EditProfileEvent {
  EditProfile();
  @override
  List<Object?> get props => [];
}

class AddAvatar extends EditProfileEvent {
  final File avatar;

  AddAvatar({required this.avatar});
  @override
  List<Object?> get props => [avatar];
}

class AddBackground extends EditProfileEvent {
  final File background;

  AddBackground({required this.background});
  @override
  List<Object?> get props => [background];
}
