import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/room/model/request_room.dart';
import 'package:wflow/modules/main/data/room/room_service.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';
import 'package:wflow/modules/main/domain/room/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomService roomService;

  RoomRepositoryImpl({required this.roomService});

  @override
  Future<HttpResponseWithPagination<RoomEntity>> getListRoom(PaginationModel request) async {
    try {
      final rooms = await roomService.getListRoom(request);
      return rooms;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }

  @override
  Future<HttpResponseWithPagination<MessagesEntity>> getListMessage(PaginationModel request, num idRoom) async {
    try {
      final messages = await roomService.getListMessage(request, idRoom);
      return messages;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }
}
