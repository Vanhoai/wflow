part of 'my_company_bloc.dart';

class MyCompanyEvent extends Equatable {
  const MyCompanyEvent();

  @override
  List<Object> get props => [];
}

class GetMyCompanyEvent extends MyCompanyEvent {
  const GetMyCompanyEvent();

  @override
  List<Object> get props => [];
}

class GetMyCompanyEventSuccess extends MyCompanyEvent {
  final CompanyEntity companyEntity;
  final bool isLoading;
  final String message;
  const GetMyCompanyEventSuccess({
    required this.companyEntity,
    required this.isLoading,
    required this.message,
  });

  @override
  List<Object> get props => [companyEntity, message, isLoading];
}

class GetMyCompanyEventFailure extends MyCompanyEvent {
  final CompanyEntity companyEntity;
  final bool isLoading;
  final String message;
  const GetMyCompanyEventFailure({
    required this.companyEntity,
    required this.isLoading,
    required this.message,
  });
  @override
  List<Object> get props => [companyEntity, message, isLoading];
}
