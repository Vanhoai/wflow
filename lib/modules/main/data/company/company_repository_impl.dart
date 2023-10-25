import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/company/company_service.dart';
import 'package:wflow/modules/main/data/company/models/response/company_model.dart';
import 'package:wflow/modules/main/domain/company/company_repository.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyService companyService;
  CompanyRepositoryImpl({required this.companyService});

  @override
  Future<CompanyEntity> getCompanyById(int id) async {
    final Either<Failure, CompanyModel> either = await companyService.getCompanyById(id);

    return either.fold((l) {
      print('============================================================= getCompanyById ${l.message}');

      return CompanyEntity.createEmpty();
    }, (r) {
      return CompanyEntity.fromJson(r.toJson());
    });
  }

  @override
  Future<CompanyEntity> myCompany() async {
    final Either<Failure, CompanyModel> either = await companyService.myCompany();

    return either.fold((l) {
      print('============================================================= myCompany ${l.message}');

      return CompanyEntity.createEmpty();
    }, (r) {
      return CompanyEntity.fromJson(r.toJson());
    });
  }
}
