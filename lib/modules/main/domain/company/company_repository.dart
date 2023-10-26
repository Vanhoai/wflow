import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

abstract class CompanyRepository {
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id);
  Future<Either<CompanyEntity, Failure>> myCompany();
}
