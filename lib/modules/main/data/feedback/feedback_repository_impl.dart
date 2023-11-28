import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/feedback/feedback_service.dart';
import 'package:wflow/modules/main/data/feedback/models/business_send_feedback_model.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  FeedbackService feedbackService;

  FeedbackRepositoryImpl({required this.feedbackService});

  @override
  Future<Either<String, Failure>> businessSendFeedback(BusinessSendFeedbackModel businessSendFeedbackModel) async {
    try {
      final response = await feedbackService.businessSendFeedback(businessSendFeedbackModel);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<List<FeedbackEntity>, Failure>> findFeedbackOfUser() async {
    try {
      final response = await feedbackService.findFeedbackOfUser();
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<ReputationEntity, Failure>> findReputation() async {
    try {
      final response = await feedbackService.findReputation();
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
}
