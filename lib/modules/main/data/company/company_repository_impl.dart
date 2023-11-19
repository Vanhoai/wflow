import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/company/company_service.dart';
import 'package:wflow/modules/main/data/company/request/update_business_rqst.dart';
import 'package:wflow/modules/main/domain/company/company_repository.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyService companyService;
  CompanyRepositoryImpl({required this.companyService});

  @override
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id) async {
    try {
      final response = await companyService.getCompanyById(id);
      return Left(CompanyEntity.fromJson(response.toJson()));
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<CompanyEntity, Failure>> myCompany() async {
    try {
      final response = await companyService.myCompany();
      return Left(CompanyEntity.fromJson(response.toJson()));
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<List<UserEntity>, Failure>> myCompanyMember(int page, int pageSize) async {
    try {
      final response = await companyService.myCompanyMember(page, pageSize);
      return Left(response.map((e) => UserEntity.fromJson(e.toJson())).toList());
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<List<PostEntity>, Failure>> myCompanyJob(int page, int pageSize) async {
    try {
      final response = await companyService.myCompanyJob(page, pageSize);
      return Left(response.map((e) => PostEntity.fromJson(e.toJson())).toList());
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<String, Failure>> upgradeBusiness({required UpgradeBusinessRequest request}) async {
    try {
      final response = await companyService.upgradeBusiness(request: request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<CompanyEntity, Failure>> findCompany({required String id}) async {
    try {
      final response = await companyService.findCompany(id: id);
      return Left(CompanyEntity.fromJson(response.toJson()));
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
  
  @override
  Future<Either<String, Failure>> updateBusiness({required RequestUpdateBusiness request}) async {
     try {
      final response = await companyService.updateBusiness(request: request);
      return Left(response);
    } on ServerException catch (exception) {
      return Right(ServerFailure(message: exception.message));
    }
  }
}
