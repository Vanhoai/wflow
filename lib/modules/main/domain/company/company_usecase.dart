import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/company/request/update_business_rqst.dart';
import 'package:wflow/modules/main/domain/company/company_repository.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class CompanyUseCase {
  Future<Either<CompanyEntity, Failure>> getCompanyById(int id);
  Future<Either<CompanyEntity, Failure>> myCompany();
  Future<Either<List<UserEntity>, Failure>> myCompanyMember(int page, int pageSize);
  Future<Either<List<PostEntity>, Failure>> myCompanyJob(int page, int pageSize, String id);
  Future<Either<String, Failure>> upgradeBusiness({required UpgradeBusinessRequest request});
  Future<Either<CompanyEntity, Failure>> findCompany({required String id});
  Future<Either<String, Failure>> updateBusiness({required RequestUpdateBusiness request});
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

  @override
  Future<Either<List<UserEntity>, Failure>> myCompanyMember(int page, int pageSize) async {
    return await companyRepository.myCompanyMember(page, pageSize);
  }

  @override
  Future<Either<List<PostEntity>, Failure>> myCompanyJob(int page, int pageSize, String id) async {
    return await companyRepository.myCompanyJob(page, pageSize, id);
  }

  @override
  Future<Either<String, Failure>> upgradeBusiness({required UpgradeBusinessRequest request}) async {
    return await companyRepository.upgradeBusiness(request: request);
  }

  @override
  Future<Either<CompanyEntity, Failure>> findCompany({required String id}) async {
    return await companyRepository.findCompany(id: id);
  }

  @override
  Future<Either<String, Failure>> updateBusiness({required RequestUpdateBusiness request}) async {
    return await companyRepository.updateBusiness(request: request);
  }
}
