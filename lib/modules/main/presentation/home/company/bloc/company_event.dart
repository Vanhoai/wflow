part of 'company_bloc.dart';

sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class CompanyEventGetByIdEvent extends CompanyEvent {
  final int id;

  const CompanyEventGetByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class CompanyMyGetEvent extends CompanyEvent {
  const CompanyMyGetEvent();

  @override
  List<Object> get props => [];
}
