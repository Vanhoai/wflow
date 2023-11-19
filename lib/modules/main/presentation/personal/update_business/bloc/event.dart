import 'dart:io';

import 'package:equatable/equatable.dart';

class UpdateBusinessEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProfile extends UpdateBusinessEvent {
  @override
  List<Object?> get props => [];
}

class UpdateBusiness extends UpdateBusinessEvent {
  UpdateBusiness();
  @override
  List<Object?> get props => [];
}

class AddAvatar extends UpdateBusinessEvent {
  final File avatar;

  AddAvatar({required this.avatar});
  @override
  List<Object?> get props => [avatar];
}

class AddBackground extends UpdateBusinessEvent {
  final File background;

  AddBackground({required this.background});
  @override
  List<Object?> get props => [background];
}
class SearchLocation extends UpdateBusinessEvent{
  
}
class OnSearchLocation extends UpdateBusinessEvent{
  final bool show;

  OnSearchLocation({required this.show});
   @override
  List<Object?> get props => [show];
}
class OnSelect extends UpdateBusinessEvent{
  final String location;

  OnSelect({required this.location});
   @override
  List<Object?> get props => [location];
}