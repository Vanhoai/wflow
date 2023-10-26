import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/company/company_service.dart';
import 'package:wflow/modules/main/domain/company/company_repository.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyService companyService;
  CompanyRepositoryImpl({required this.companyService});

  @override
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id) async {
    try {
      final response = await companyService.getCompanyById(id);
      return Left(CompanyEntity.fromJson(response.toJson()));
    } catch (e) {
      if (e is CommonFailure) {
        return Right(CommonFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is ServerFailure) {
        return Right(ServerFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is CacheFailure) {
        return Right(CacheFailure(message: e.message, statusCode: e.statusCode));
      } else {
        return const Right(ServerFailure());
      }
    }
  }

  @override
  Future<Either<CompanyEntity, Failure>> myCompany() async {
    try {
      final response = await companyService.myCompany();
      return Left(CompanyEntity.fromJson(response.toJson()));
    } catch (e) {
      if (e is CommonFailure) {
        return Right(CommonFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is ServerFailure) {
        return Right(ServerFailure(message: e.message, statusCode: e.statusCode));
      } else if (e is CacheFailure) {
        return Right(CacheFailure(message: e.message, statusCode: e.statusCode));
      } else {
        return const Right(ServerFailure());
      }
    }
  }
}
