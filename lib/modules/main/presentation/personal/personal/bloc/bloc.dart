import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';

part 'event.dart';
part 'state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final UserUseCase userUseCase;

  PersonalBloc({required this.userUseCase})
      : super(PersonalState(
          isLoading: true,
          isSignOut: false,
          message: '',
          userEntity: UserEntity.createEmpty(),
        )) {
    on<SignOutEvent>(onSignOut);
    on<GetPersonalInformationEvent>(onGetPersonalInformation);
    on<RefreshPersonalInformationEvent>(onRefreshPersonalInformation);
  }

  void onSignOut(SignOutEvent signOutEvent, Emitter<PersonalState> emit) {
    emit(
      state.copyWith(
        isSignOut: true,
        message: 'Sign out successfully',
        userEntity: UserEntity.createEmpty(),
        isLoading: false,
      ),
    );
  }

  FutureOr onGetPersonalInformation(
      GetPersonalInformationEvent getPersonalInformationEvent, Emitter<PersonalState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    emit(state.copyWith(
      isLoading: getPersonalInformationEvent.isLoading,
      message: getPersonalInformationEvent.message,
    ));
    final Either<UserEntity, Failure> result = await userUseCase.myProfile();
    result.fold(
      (UserEntity l) {
        emit(state.copyWith(isLoading: false, message: 'Get personal information successfully', userEntity: l));
      },
      (Failure r) {
        emit(state.copyWith(isLoading: false, message: r.message));
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr onRefreshPersonalInformation(
      RefreshPersonalInformationEvent refreshPersonalInformationEvent, Emitter<PersonalState> emit) async {
    emit(state.copyWith(
      isLoading: refreshPersonalInformationEvent.isLoading,
      message: refreshPersonalInformationEvent.message,
    ));
  }
}
