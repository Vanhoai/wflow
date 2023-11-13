import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/tracking/entities/tracking_entity.dart';
import 'package:wflow/modules/main/domain/tracking/tracking_repository.dart';

abstract class TrackingUseCase {
  Future<Either<List<TrackingEntity>, Failure>> findTrackingInBalance({required num id});
}

class TrackingUseCaseImpl implements TrackingUseCase {
  final TrackingRepository trackingRepository;
  TrackingUseCaseImpl({required this.trackingRepository});

  @override
  Future<Either<List<TrackingEntity>, Failure>> findTrackingInBalance({required num id}) async {
    return await trackingRepository.findTrackingInBalance(id: id);
  }
}
