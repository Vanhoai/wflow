import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/room/model/request_room.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';
import 'package:wflow/modules/main/domain/room/room_repository.dart';

abstract class RoomUseCase {
  Future<HttpResponseWithPagination<RoomEntity>> getListRoom(PaginationModel request);
  Future<HttpResponseWithPagination<MessagesEntity>> getListMessage(PaginationModel request, num idRoom);
}

class RoomUseCaseImpl implements RoomUseCase {
  final RoomRepository roomRepository;

  RoomUseCaseImpl({required this.roomRepository});

  @override
  Future<HttpResponseWithPagination<RoomEntity>> getListRoom(PaginationModel request) async {
    return await roomRepository.getListRoom(request);
  }

  @override
  Future<HttpResponseWithPagination<MessagesEntity>> getListMessage(PaginationModel request, num idRoom) async {
    return await roomRepository.getListMessage(request, idRoom);
  }
}
