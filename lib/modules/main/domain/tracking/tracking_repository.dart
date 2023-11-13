import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/tracking/entities/tracking_entity.dart';

abstract class TrackingRepository {
  Future<Either<List<TrackingEntity>, Failure>> findTrackingInBalance({required num id});
}
