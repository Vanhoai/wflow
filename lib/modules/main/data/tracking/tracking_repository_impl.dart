import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/tracking/tracking_service.dart';
import 'package:wflow/modules/main/domain/tracking/entities/tracking_entity.dart';
import 'package:wflow/modules/main/domain/tracking/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingService trackingService;
  TrackingRepositoryImpl({required this.trackingService});

  @override
  Future<Either<List<TrackingEntity>, Failure>> findTrackingInBalance({required num id}) async {
    try {
      final response = await trackingService.findTrackingInBalance(id: id);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
}
