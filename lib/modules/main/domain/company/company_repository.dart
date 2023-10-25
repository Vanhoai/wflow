import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

abstract class CompanyRepository {
  Future<CompanyEntity> getCompanyById(int id);
  Future<CompanyEntity> myCompany();
}
