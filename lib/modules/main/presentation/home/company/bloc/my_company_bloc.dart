import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

part 'my_company_event.dart';
part 'my_company_state.dart';

class MyCompanyBloc extends Bloc<MyCompanyEvent, MyCompanyState> {
  final CompanyUseCase companyUseCase;

  MyCompanyBloc({required this.companyUseCase})
      : super(MyCompanyState(
          companyEntity: CompanyEntity.createEmpty(),
          message: '',
          isLoading: true,
        )) {
    on<MyCompanyEvent>(onMyCompany);
    on<GetMyCompanyEvent>(onGetMyCompany);
  }

  Future<void> onMyCompany(MyCompanyEvent event, Emitter<MyCompanyState> emit) async {
    emit(state.copyWith(CompanyEntity.createEmpty(), false, 'Success'));
  }

  FutureOr onGetMyCompany(GetMyCompanyEvent companyMyGetEvent, Emitter<MyCompanyState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final Either<CompanyEntity, Failure> result = await companyUseCase.myCompany();

    result.fold((CompanyEntity l) {
      emit(MyCompanySuccessState(
        companyEntity: l,
        message: 'Success',
        isLoading: false,
      ));
    }, (Failure r) {
      emit(MyCompanyFailureState(
        companyEntity: CompanyEntity.createEmpty(),
        message: r.message,
        isLoading: false,
      ));
    });

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
