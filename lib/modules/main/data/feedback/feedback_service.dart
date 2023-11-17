import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/feedback/models/business_send_feedback_model.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';

abstract class FeedbackService {
  Future<ReputationEntity> findReputation();
  Future<List<FeedbackEntity>> findFeedbackOfUser();
  Future<HttpResponse> businessSendFeedback(BusinessSendFeedbackModel businessSendFeedbackModel);
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
  Future<HttpResponse> businessSendFeedback(BusinessSendFeedbackModel businessSendFeedbackModel) {
    throw UnimplementedError();
  }

  @override
  Future<List<FeedbackEntity>> findFeedbackOfUser() async {
    try {
      final response = await agent.dio.get(FeedbackPath.findFeedbackOfUser);
      HttpResponseWithPagination httpResponse = HttpResponseWithPagination.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message.toString());
      }
      return httpResponse.data.map((e) => FeedbackEntity.fromJson(e)).toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ReputationEntity> findReputation() async {
    try {
      final response = await agent.dio.get(FeedbackPath.findReputation);
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message.toString());
      }

      return ReputationEntity.fromJson(httpResponse.data);
    } on ServerException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException();
    }
  }
}
