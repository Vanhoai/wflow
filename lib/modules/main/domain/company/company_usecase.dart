import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/company/company_repository.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

abstract class CompanyUseCase {
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id);
  Future<Either<CompanyEntity, Failure>> myCompany();
}

class CompanyUseCaseImpl extends CompanyUseCase {
  final CompanyRepository companyRepository;

  CompanyUseCaseImpl({required this.companyRepository});

  @override
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id) async {
    return await companyRepository.getCompanyById(id);
  }

  @override
  Future<Either<CompanyEntity, Failure>> myCompany() async {
    return await companyRepository.myCompany();
  }
}
