import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';

part 'event.dart';
part 'state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final UserUseCase userUseCase;

  PersonalBloc({required this.userUseCase})
      : super(PersonalState(
          isLoading: true,
          userEntity: UserEntity.createEmpty(),
        )) {
    on<SignOutEvent>(onSignOut);
    on<GetPersonalInformationEvent>(onGetPersonalInformation);
    on<RefreshPersonalInformationEvent>(onRefreshPersonalInformation);
  }

  Future<void> onSignOut(SignOutEvent signOutEvent, Emitter<PersonalState> emit) async {
    instance.get<NavigationService>().pop();
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    instance.get<AppBloc>().add(AppLogoutEvent());
    final business = instance.get<AppBloc>().state.userEntity.business;
    if (business != 0) {
      await FirebaseMessagingService.subscribeToTopic(business.toString());
    }
    instance.get<NavigationService>().pushNamedAndRemoveUntil(RouteKeys.signInScreen);
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr onGetPersonalInformation(GetPersonalInformationEvent event, Emitter<PersonalState> emit) async {
    emit(state.copyWith(isLoading: true));

    final response = await userUseCase.myProfile();
    response.fold(
      (UserEntity userEntity) {
        emit(state.copyWith(userEntity: userEntity));
      },
      (Failure failure) {
        AlertUtils.showMessage(
          instance.get<AppLocalization>().translate('notification'),
          instance.get<AppLocalization>().translate('errorWhenGetProfile'),
        );
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  FutureOr onRefreshPersonalInformation(RefreshPersonalInformationEvent event, Emitter<PersonalState> emit) async {
    add(GetPersonalInformationEvent());
  }
}
