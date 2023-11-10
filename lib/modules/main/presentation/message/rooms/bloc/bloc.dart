import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/data/room/model/request_room.dart';
import 'package:wflow/modules/main/domain/room/room_usecase.dart';
import 'package:wflow/modules/main/presentation/message/rooms/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/rooms/bloc/state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomUseCase roomUseCase;

  RoomBloc({required this.roomUseCase}) : super(const RoomState()) {
    on<GetListRoomEvent>(getListRoom);
    on<GetListRoomMoreEvent>(getListRoomMore);
  }

  FutureOr<void> getListRoom(GetListRoomEvent event, Emitter<RoomState> emit) async {
    if (state is! GetListRoomSuccess) {
      emit(state.copyWith(isLoading: true));
    }
    final roomEntities = await roomUseCase.getListRoom(const PaginationModel(page: 1, pageSize: 10, search: ""));

    emit(GetListRoomSuccess(
      roomEntities: roomEntities.data,
      meta: roomEntities.meta,
      isLoading: false,
      loadMore: false,
      search: state.search,
    ));
  }

  FutureOr<void> getListRoomMore(GetListRoomMoreEvent event, Emitter<RoomState> emit) async {
    if (state is GetListRoomSuccess) {
      emit((state as GetListRoomSuccess).copyWith(loadMore: true));
      if (state.meta.currentPage >= state.meta.totalPage) {
        emit((state as GetListRoomSuccess).copyWith(loadMore: false));
        return;
      }
      final candidateList = await roomUseCase
          .getListRoom(PaginationModel(page: state.meta.currentPage + 1 as int, pageSize: 10, search: state.search));
      emit((state as GetListRoomSuccess).copyWith(
          loadMore: false,
          roomEntities: [...(state as GetListRoomSuccess).roomEntities, ...candidateList.data],
          meta: candidateList.meta));
    }
  }
}
