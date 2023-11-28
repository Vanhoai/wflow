import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/feedback/models/business_send_feedback_model.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';

abstract class FeedbackRepository {
  Future<Either<ReputationEntity, Failure>> findReputation();
  Future<Either<List<FeedbackEntity>, Failure>> findFeedbackOfUser();
  Future<Either<String, Failure>> businessSendFeedback(BusinessSendFeedbackModel businessSendFeedbackModel);
}
