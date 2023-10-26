part of 'my_company_bloc.dart';

class MyCompanyState extends Equatable {
  final CompanyEntity companyEntity;
  final String message;
  final bool isLoading;

  const MyCompanyState({
    required this.isLoading,
    required this.message,
    required this.companyEntity,
  });

  MyCompanyState copyWith(
    CompanyEntity? companyEntity,
    bool? isLoading,
    String? message,
  ) {
    return MyCompanyState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      companyEntity: companyEntity ?? this.companyEntity,
    );
  }

  @override
  List<Object> get props => [companyEntity, message, isLoading];
}

class MyCompanySuccessState extends MyCompanyState {
  const MyCompanySuccessState({
    required CompanyEntity companyEntity,
    required String message,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          message: message,
          companyEntity: companyEntity,
        );

  @override
  List<Object> get props => [companyEntity, message, isLoading];

  @override
  MyCompanySuccessState copyWith(
    CompanyEntity? companyEntity,
    bool? isLoading,
    String? message,
  ) {
    return MyCompanySuccessState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      companyEntity: companyEntity ?? this.companyEntity,
    );
  }

  @override
  String toString() => 'MyCompanySuccessState { message: $message, companyEntity: $companyEntity }';
}

class MyCompanyFailureState extends MyCompanyState {
  const MyCompanyFailureState({
    required CompanyEntity companyEntity,
    required String message,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          message: message,
          companyEntity: companyEntity,
        );

  @override
  List<Object> get props => [companyEntity, message, isLoading];

  @override
  MyCompanyFailureState copyWith(
    CompanyEntity? companyEntity,
    bool? isLoading,
    String? message,
  ) {
    return MyCompanyFailureState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      companyEntity: companyEntity ?? this.companyEntity,
    );
  }

  @override
  String toString() => 'MyCompanyFailureState { message: $message, companyEntity: $companyEntity }';
}
