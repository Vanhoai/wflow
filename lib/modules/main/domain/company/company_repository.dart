import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/user/user_entity.dart';

abstract class CompanyRepository {
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id);
  Future<Either<CompanyEntity, Failure>> myCompany();
  Future<Either<List<UserEntity>, Failure>> myCompanyMember(int page, int pageSize);
  Future<Either<List<PostEntity>, Failure>> myCompanyJob(int page, int pageSize);
}
