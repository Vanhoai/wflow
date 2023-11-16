import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/feedback/models/business_send_feedback_model.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_repository.dart';

abstract class FeedbackUseCase {
  Future<Either<ReputationEntity, Failure>> findReputation();
  Future<Either<List<FeedbackEntity>, Failure>> findFeedbackOfUser();
  Future<Either<HttpResponse, Failure>> businessSendFeedback(BusinessSendFeedbackModel businessSendFeedbackModel);
}

class FeedbackUseCaseImpl implements FeedbackUseCase {
  final FeedbackRepository feedbackRepository;

  const FeedbackUseCaseImpl({required this.feedbackRepository});

  @override
  Future<Either<ReputationEntity, Failure>> findReputation() async {
    return await feedbackRepository.findReputation();
  }

  @override
  Future<Either<List<FeedbackEntity>, Failure>> findFeedbackOfUser() async {
    return await feedbackRepository.findFeedbackOfUser();
  }

  @override
  Future<Either<HttpResponse, Failure>> businessSendFeedback(
      BusinessSendFeedbackModel businessSendFeedbackModel) async {
    return await feedbackRepository.businessSendFeedback(businessSendFeedbackModel);
  }
}
