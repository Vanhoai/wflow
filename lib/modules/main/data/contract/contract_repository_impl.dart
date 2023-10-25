import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/contract/contract_service.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';

class ContractRepositoryImpl implements ContractRepository {
  final ContractService contactService;

  ContractRepositoryImpl({required this.contactService});
  @override
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request) async {
    try {
      final messageRespond = await contactService.applyPost(request);
      return Left(messageRespond);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
}
