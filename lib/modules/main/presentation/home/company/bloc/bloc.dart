import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

part 'event.dart';
part 'state.dart';

class MyCompanyBloc extends Bloc<MyCompanyEvent, MyCompanyState> {
  final CompanyUseCase companyUseCase;

  MyCompanyBloc({required this.companyUseCase})
      : super(
          MyCompanyState(
            companyEntity: CompanyEntity.createEmpty(),
            listUser: const [],
            isLoadingCompany: false,
            isLoadingMember: false,
            isLoadingPost: false,
            message: '',
          ),
        ) {
    on<GetMyCompanyEvent>(onGetMyCompany);
    on<GetMyMemberCompanyEvent>(onGetMyMemberCompany);
    on<GetMyPostCompanyEvent>(onGetMyJobCompany);
  }

  Future onGetMyCompany(GetMyCompanyEvent event, Emitter<MyCompanyState> emit) async {
    emit(state.copyWith(isLoadingCompany: event.isLoading, message: event.message));
    final Either<CompanyEntity, Failure> result = await companyUseCase.findCompany(id: event.id);
    result.fold((CompanyEntity l) {
      emit(state.copyWith(companyEntity: l, isLoadingCompany: false, message: 'Load company success'));
    }, (Failure r) {
      emit(state.copyWith(isLoadingCompany: false, message: r.message));
    });
  }

  Future onGetMyMemberCompany(GetMyMemberCompanyEvent getMyMemberCompanyEvent, Emitter<MyCompanyState> emit) async {
    emit(state.copyWith(isLoadingMember: getMyMemberCompanyEvent.isLoading, message: getMyMemberCompanyEvent.message));
    final query = [getMyMemberCompanyEvent.page, getMyMemberCompanyEvent.pageSize];
    final Either<List<UserEntity>, Failure> result = await companyUseCase.myCompanyMember(query[0], query[1]);
    result.fold(
      (List<UserEntity> l) => emit(state.copyWith(listUser: l, isLoadingMember: false, message: 'Load member success')),
      (Failure r) {
        emit(state.copyWith(isLoadingMember: false, message: r.message));
      },
    );
  }

  Future onGetMyJobCompany(GetMyPostCompanyEvent getMyPostCompanyEvent, Emitter<MyCompanyState> emit) async {
    emit(state.copyWith(isLoadingPost: getMyPostCompanyEvent.isLoading, message: getMyPostCompanyEvent.message));
    final query = [getMyPostCompanyEvent.page, getMyPostCompanyEvent.pageSize];
    final Either<List<PostEntity>, Failure> result = await companyUseCase.myCompanyJob(query[0], query[1]);
    result.fold(
      (List<PostEntity> l) => emit(state.copyWith(listPost: l, isLoadingPost: false, message: 'Load job success')),
      (Failure r) {
        emit(state.copyWith(isLoadingPost: false, message: r.message));
      },
    );
  }
}
