import 'package:equatable/equatable.dart';

class RoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetListRoomEvent extends RoomEvent {
  GetListRoomEvent();
  @override
  List<Object?> get props => [];
}

class GetListRoomMoreEvent extends GetListRoomEvent {
  GetListRoomMoreEvent();
  @override
  List<Object?> get props => [];
}

class GetListRoomSearchEvent extends GetListRoomEvent {
  final String search;

  GetListRoomSearchEvent({required this.search});
  @override
  List<Object?> get props => [search];
}
