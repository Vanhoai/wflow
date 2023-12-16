import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/company/request/update_business_rqst.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class CompanyRepository {
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id);
  Future<Either<CompanyEntity, Failure>> myCompany();
  Future<Either<List<UserEntity>, Failure>> myCompanyMember(int page, int pageSize);
  Future<Either<List<PostEntity>, Failure>> myCompanyJob(int page, int pageSize, String id);
  Future<Either<String, Failure>> upgradeBusiness({required UpgradeBusinessRequest request});
  Future<Either<CompanyEntity, Failure>> findCompany({required String id});
  Future<Either<String, Failure>> updateBusiness({required RequestUpdateBusiness request});
}
