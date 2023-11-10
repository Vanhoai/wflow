import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/room/model/request_room.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';

abstract class RoomRepository {
  Future<HttpResponseWithPagination<RoomEntity>> getListRoom(PaginationModel request);
  Future<HttpResponseWithPagination<MessagesEntity>> getListMessage(PaginationModel request, num idRoom);
}
