import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/room/model/request_room.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';

abstract class RoomService {
  Future<HttpResponseWithPagination<RoomEntity>> getListRoom(PaginationModel request);

  Future<HttpResponseWithPagination<MessagesEntity>> getListMessage(PaginationModel request, num idRoom);
}

class RoomServiceImpl implements RoomService {
  final Agent agent;

  RoomServiceImpl({required this.agent});

  @override
  Future<HttpResponseWithPagination<RoomEntity>> getListRoom(PaginationModel request) async {
    try {
      final response = await agent.dio.get(
        '/room',
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'search': request.search,
        },
      );
      HttpResponseWithPagination<dynamic> httpResponse = HttpResponseWithPagination.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<RoomEntity> rooms = httpResponse.data.map((e) => RoomEntity.fromJson(e)).toList();

      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: rooms,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<MessagesEntity>> getListMessage(PaginationModel request, num idRoom) async {
    try {
      final response = await agent.dio.get(
        '/message/$idRoom',
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'search': request.search,
        },
      );
      HttpResponseWithPagination<dynamic> httpResponse = HttpResponseWithPagination.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<MessagesEntity> messages = httpResponse.data.map((e) => MessagesEntity.fromJson(e)).toList();

      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: messages,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
