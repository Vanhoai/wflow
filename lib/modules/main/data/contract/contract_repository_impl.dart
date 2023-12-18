import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/contract/contract_service.dart';
import 'package:wflow/modules/main/data/contract/model/request_apply_model.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';
import 'package:wflow/modules/main/domain/contract/entities/candidate_entity.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

class ContractRepositoryImpl implements ContractRepository {
  final ContractService contactService;

  ContractRepositoryImpl({required this.contactService});

  @override
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request) async {
    try {
      final messageRespond = await contactService.applyPost(request);
      return Left(messageRespond);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<ContractEntity, Failure>> candidateAppliedDetail(
      String id) async {
    try {
      final candidateDetail = await contactService.candidateAppliedDetail(id);
      return Left(candidateDetail);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<HttpResponseWithPagination<CandidateEntity>> getCandidateApplied(
      num id, GetCandidateApplied request) async {
    try {
      final response = await contactService.getCandidateApplied(id, request);
      return response;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }

  @override
  Future<Either<String, Failure>> createContract(
      CreateContractModel request) async {
    try {
      final response = await contactService.createContract(request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractAcceptedOfUser(
      GetContractOfUserAndBusiness request) async {
    try {
      final response = await contactService.findContractAccepted(request);
      return response;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractWaitingSign(
      GetContractWaitingSign request) async {
    try {
      final response = await contactService.findContractWaitingSign(request);
      return response;
    } on ServerException {
      return HttpResponseWithPagination.empty();
    }
  }

  @override
  Future<Either<String, Failure>> businessSignContract(int id) async {
    try {
      final response = await contactService.businessSignContract(id);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> workerSignContract(int id) async {
    try {
      final response = await contactService.workerSignContract(id);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<HttpResponseWithPagination<ContractEntity>> findContractSigned(
      GetContractSigned request) async {
    try {
      final response = await contactService.findContractSigned(request);
      return response;
    } catch (exception) {
      return HttpResponseWithPagination.empty();
    }
  }

  @override
  Future<Either<HttpResponseWithPagination<ContractEntity>, Failure>>
      getContractApplies(RequestApplyModel requestApplyModel) async {
    try {
      final result = await contactService.getContractApplies(requestApplyModel);
      return Left(result);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> checkContractAndTransfer(int id) async {
    try {
      final response = await contactService.checkContractAndTransfer(id);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<HttpResponseWithPagination<ContractEntity>, Failure>>
      getContractCompleted(GetContractSigned req) async {
    try {
      final result = await contactService.getContractCompleted(req);
      return Left(result);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
  
  @override
  Future<Either<String, Failure>> findContractById(int id) async {
     try {
      final posts = await contactService.findContractById(id);
      return Left(posts);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<List<TaskEntity>, Failure>> uploadFileAddToContact(RequestAddTaskExcel request) async {
   try {
      final tasks = await contactService.uploadFileAddToContact(request);
      return Left(tasks);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
  
  @override
  Future<Either<String, Failure>> workerCancelContract(int id) async {
     try {
      final response = await contactService.workerCancelContract(id);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
}
