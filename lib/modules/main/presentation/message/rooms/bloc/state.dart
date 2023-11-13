import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/meta/meta_model.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';

class RoomState extends Equatable {
  final bool isLoading;
  final Meta meta;
  final String search;

  const RoomState({
    this.isLoading = false,
    this.meta = const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
    this.search = '',
  });
  RoomState copyWith({bool? isLoading}) {
    return RoomState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading, meta, search];
}

class GetListRoomSuccess extends RoomState {
  final List<RoomEntity> roomEntities;
  final bool loadMore;

  const GetListRoomSuccess({
    required this.roomEntities,
    super.meta,
    required super.isLoading,
    required this.loadMore,
    required super.search,
  });
  @override
  GetListRoomSuccess copyWith({
    List<RoomEntity>? roomEntities,
    bool? loadMore,
    bool? isLoading,
    Meta? meta,
    String? search,
  }) {
    return GetListRoomSuccess(
      roomEntities: roomEntities ?? this.roomEntities,
      meta: meta ?? super.meta,
      isLoading: isLoading ?? super.isLoading,
      loadMore: loadMore ?? this.loadMore,
      search: search ?? super.search,
    );
  }

  @override
  List<Object?> get props => [roomEntities, meta, isLoading, loadMore];
}
