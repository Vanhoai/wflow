import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';

abstract class ContractUseCase {
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request);
}

class ContractUseCaseImpl implements ContractUseCase {
  final ContractRepository contactRepository;

  ContractUseCaseImpl({required this.contactRepository});

  @override
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request) async {
    return await contactRepository.applyPost(request);
  }
}
