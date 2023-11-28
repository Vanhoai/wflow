import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/feedback/models/business_send_feedback_model.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';

abstract class FeedbackService {
  Future<ReputationEntity> findReputation();
  Future<List<FeedbackEntity>> findFeedbackOfUser();
  Future<String> businessSendFeedback(BusinessSendFeedbackModel businessSendFeedbackModel);
}

class FeedbackPath {
  static const String findReputation = '/feedback/reputation';
  static const String businessSendFeedback = '/feedback/business-send-feedback';
  static const String findFeedbackOfUser = '/feedback/feedbacks-of-user';
}

class FeedbackServiceImpl implements FeedbackService {
  Agent agent;
  FeedbackServiceImpl({required this.agent});

  @override
  Future<String> businessSendFeedback(BusinessSendFeedbackModel businessSendFeedbackModel) async {
    try {
      final response =
          await agent.dio.post(FeedbackPath.businessSendFeedback, data: businessSendFeedbackModel.toJson());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }
      return httpResponse.message;
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<List<FeedbackEntity>> findFeedbackOfUser() async {
    try {
      final response = await agent.dio.get(FeedbackPath.findFeedbackOfUser);
      HttpResponseWithPagination httpResponse = HttpResponseWithPagination.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }
      return httpResponse.data.map((e) => FeedbackEntity.fromJson(e)).toList();
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<ReputationEntity> findReputation() async {
    try {
      final response = await agent.dio.get(FeedbackPath.findReputation);
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return ReputationEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }
}
