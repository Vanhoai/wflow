import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_repository.dart';

abstract class ContactUseCase {
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request);
}

class ContactUseCaseImpl implements ContactUseCase {
  final ContactRepository contactRepository;

  ContactUseCaseImpl({required this.contactRepository});

  @override
  Future<Either<String, Failure>> applyPost(ApplyPostRequest request) async {
    return await contactRepository.applyPost(request);
  }
}
