import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/domain/tracking/entities/tracking_entity.dart';

class TrackingPaths {
  static String findContractInBalance({required num id}) => '/tracking/find-all-tracking/$id';
}

abstract class TrackingService {
  Future<List<TrackingEntity>> findTrackingInBalance({required num id});
}

class TrackingServiceImpl implements TrackingService {
  final Agent agent;
  TrackingServiceImpl({required this.agent});

  @override
  Future<List<TrackingEntity>> findTrackingInBalance({required num id}) async {
    try {
      final response = await agent.dio.get(TrackingPaths.findContractInBalance(id: id));
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<TrackingEntity> trackingEntity = [];
      httpResponse.data.forEach((element) {
        trackingEntity.add(TrackingEntity.fromJson(element));
      });

      return trackingEntity;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
