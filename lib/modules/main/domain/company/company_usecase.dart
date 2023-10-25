import 'package:wflow/modules/main/domain/company/company_repository.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

abstract class CompanyUseCase {
  Future<CompanyEntity> getCompanyById(int id);
  Future<CompanyEntity> myCompany();
}

class CompanyUseCaseImpl extends CompanyUseCase {
  final CompanyRepository companyRepository;

  CompanyUseCaseImpl({required this.companyRepository});

  @override
  Future<CompanyEntity> getCompanyById(int id) async {
    return await companyRepository.getCompanyById(id);
  }

  @override
  Future<CompanyEntity> myCompany() async {
    return await companyRepository.myCompany();
  }
}
