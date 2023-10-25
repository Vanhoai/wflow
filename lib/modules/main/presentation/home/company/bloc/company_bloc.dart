import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyUseCase companyUseCase;

  CompanyBloc({required this.companyUseCase}) : super(CompanyState(companyEntity: CompanyEntity.createEmpty())) {
    on<CompanyEventGetByIdEvent>(onGetCompanyById);
    on<CompanyMyGetEvent>(onGetMyCompany);
  }

  FutureOr onGetCompanyById(CompanyEventGetByIdEvent companyEventGetByIdEvent, Emitter<CompanyState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final CompanyEntity result = await companyUseCase.getCompanyById(companyEventGetByIdEvent.id);
    emit(state.copyWith(result));
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr onGetMyCompany(CompanyMyGetEvent companyMyGetEvent, Emitter<CompanyState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final CompanyEntity result = await companyUseCase.myCompany();
    emit(state.copyWith(result));
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
