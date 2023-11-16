import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/exception.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_apply_model.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/entities/candidate_entity.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

abstract class ContractService {
  Future<String> applyPost(ApplyPostRequest request);
  Future<String> businessSignContract(int id);
  Future<ContractEntity> candidateAppliedDetail(String id);
  Future<String> createContract(CreateContractModel request);
  Future<HttpResponseWithPagination<ContractEntity>> findContractAcceptedOfUser(
      GetCandidateApplied request);
  Future<HttpResponseWithPagination<ContractEntity>> findContractWaitingSign(
      GetContractWaitingSign request);
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(
      num id, GetCandidateApplied request);
  Future<String> workerSignContract(int id);
  Future<HttpResponseWithPagination<ContractEntity>> findContractSigned(
      GetContractSigned request);
  Future<HttpResponseWithPagination<ContractEntity>> getContractApplies(
      RequestApplyModel requestApplyModel);
}

class ContractPaths {
  static const String applyPost = '/contract/apply-post';
  static String getPathBusinessSignContract(int id) =>
      '/contract/business-sign-contract/$id';
  static String getPathCandidateAppliedDetail(String id) =>
      '/contract/candidate-applied-detail/$id';
  static const String createContract = '/contract/update-contract';
  static const String findContractAcceptedOfUser =
      '/contract/find-contract-accepted-of-user';
  static const String findContractWaitingSignOfUser =
      '/contract/find-contract-waiting-sign-of-user';
  static const String findContractWaitingSignOfBusiness =
      '/contract/find-contract-waiting-sign-of-business';
  static String getPathCandidateApplied(num id) =>
      '/contract/candidate-applied/$id';
  static String getPathWorkerSignContract(int id) =>
      '/contract/worker-sign-contract/$id';
  static const String findContractSignedOfUser =
      '/contract/find-contract-signed-of-user';
  static const String findContractSignedOfBusiness =
      '/contract/find-contract-signed-of-business';
  static const String getContractApplies = '/contract/find-post-applied';
}

class ContractServiceImpl implements ContractService {
  final Agent agent;

  ContractServiceImpl({required this.agent});

  @override
  Future<String> applyPost(ApplyPostRequest request) async {
    try {
      final response =
          await agent.dio.post(ContractPaths.applyPost, data: request.toJson());
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      return httpResponse.message;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> businessSignContract(int id) async {
    try {
      final response = await agent.dio.patch(
        ContractPaths.getPathBusinessSignContract(id),
      );

      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.data;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<ContractEntity> candidateAppliedDetail(String id) async {
    try {
      final response = await agent.dio.get(
        ContractPaths.getPathCandidateAppliedDetail(id),
      );
      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return ContractEntity.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> createContract(CreateContractModel request) async {
    try {
      final response = await agent.dio.put(
        ContractPaths.createContract,
        data: request.toJson(),
      );

      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.message;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractAcceptedOfUser(
      GetCandidateApplied request) async {
    try {
      final response = await agent.dio.get(
        ContractPaths.findContractAcceptedOfUser,
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'search': request.search,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponse =
          HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<ContractEntity> contracts =
          httpResponse.data.map((e) => ContractEntity.fromJson(e)).toList();
      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: contracts,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractWaitingSign(
      GetContractWaitingSign request) async {
    try {
      final url = request.isBusiness
          ? ContractPaths.findContractWaitingSignOfBusiness
          : ContractPaths.findContractWaitingSignOfUser;

      final response = await agent.dio.get(
        url,
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'search': request.search,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponse =
          HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<ContractEntity> contracts =
          httpResponse.data.map((e) => ContractEntity.fromJson(e)).toList();
      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: contracts,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(
      num id, request) async {
    try {
      final response = await agent.dio.get(
        ContractPaths.getPathCandidateApplied(id),
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'search': request.search,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponse =
          HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<CandidateEntity> posts =
          httpResponse.data.map((e) => CandidateEntity.fromJson(e)).toList();
      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: posts,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> workerSignContract(int id) async {
    try {
      final response = await agent.dio.patch(
        ContractPaths.getPathWorkerSignContract(id),
      );

      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.data;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractSigned(
      GetContractSigned request) async {
    try {
      final url = request.isBusiness
          ? ContractPaths.findContractSignedOfBusiness
          : ContractPaths.findContractSignedOfUser;

      final response = await agent.dio.get(
        url,
        queryParameters: {
          'page': request.page,
          'pageSize': request.pageSize,
          'search': request.search,
        },
      );

      HttpResponseWithPagination<dynamic> httpResponse =
          HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<ContractEntity> contracts =
          httpResponse.data.map((e) => ContractEntity.fromJson(e)).toList();
      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: contracts,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> getContractApplies(
      RequestApplyModel requestApplyModel) async {
    try {
      final response = await agent.dio
          .get(ContractPaths.getContractApplies, queryParameters: {
        'page': requestApplyModel.page,
        'pageSize': requestApplyModel.pageSize,
        'search': requestApplyModel.search,
      });

      HttpResponseWithPagination<dynamic> httpResponseWithPagination =
          HttpResponseWithPagination.fromJson(response.data);

      if (httpResponseWithPagination.statusCode != 200) {
        throw ServerException(message: httpResponseWithPagination.message);
      }

      final applies = [
        ...httpResponseWithPagination.data
            .map((e) => ContractEntity.fromJson(e))
      ];

      return HttpResponseWithPagination(
        statusCode: httpResponseWithPagination.statusCode,
        message: httpResponseWithPagination.message,
        meta: httpResponseWithPagination.meta,
        data: applies,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
