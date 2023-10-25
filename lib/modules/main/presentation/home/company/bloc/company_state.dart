part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final CompanyEntity companyEntity;

  const CompanyState({required this.companyEntity});

  CompanyState copyWith(
    CompanyEntity? companyEntity,
  ) {
    return CompanyState(
      companyEntity: companyEntity ?? this.companyEntity,
    );
  }

  @override
  List<Object> get props => [companyEntity];
}
