import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/state.dart';

class AddBusinessBloc extends Bloc<AddBusinessEvent, AddBusinessState> {
  final UserUseCase userUseCase;

  AddBusinessBloc({required this.userUseCase})
      : super(
          AddBusinessState(
            meta: Meta.empty(),
            users: const [],
            usersChecked: const [],
          ),
        ) {
    on<InitAddBusinessEvent>(onInitAddBusiness);
    on<SearchAddBusinessEvent>(onSearchAddBusiness);
    on<RefreshAddBusinessEvent>(onRefreshAddBusiness);
    on<UserCheckedAddBusinessEvent>(onUserCheckedAddBusiness);
    on<AddCollaboratorAddBusinessEvent>(onAddCollaboratorAddBusiness);
    on<LoadMoreAddBusinessEvent>(onLoadMoreAddBusiness);
  }

  Future<void> onInitAddBusiness(InitAddBusinessEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final result = await userUseCase.getUsersNotBusiness(getUserNotBusinessModel: const GetUserNotBusinessModel());
    result.fold(
      (HttpResponseWithPagination<UserEntity> users) {
        emit(state.copyWith(users: users.data, meta: users.meta));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message, callback: () {
          instance.get<NavigationService>().pop();
        });
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onSearchAddBusiness(SearchAddBusinessEvent event, Emitter emit) async {
    GetUserNotBusinessModel getUserNotBusinessModel = GetUserNotBusinessModel(search: event.search);
    final result = await userUseCase.getUsersNotBusiness(getUserNotBusinessModel: getUserNotBusinessModel);

    result.fold(
      (HttpResponseWithPagination<UserEntity> users) {
        emit(state.copyWith(users: users.data, meta: users.meta));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message, callback: () {
          instance.get<NavigationService>().pop();
        });
      },
    );
  }

  Future<void> onRefreshAddBusiness(RefreshAddBusinessEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final result = await userUseCase.getUsersNotBusiness(getUserNotBusinessModel: const GetUserNotBusinessModel());
    result.fold(
      (HttpResponseWithPagination<UserEntity> users) {
        emit(state.copyWith(users: users.data, meta: users.meta));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message, callback: () {
          instance.get<NavigationService>().pop();
        });
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onUserCheckedAddBusiness(UserCheckedAddBusinessEvent event, Emitter emit) async {
    List<int> usersChecked = [...state.usersChecked];
    if (event.isChecked) {
      usersChecked.add(event.id);
    } else {
      usersChecked.remove(event.id);
    }

    emit(state.copyWith(usersChecked: usersChecked));
  }

  Future<void> onAddCollaboratorAddBusiness(AddCollaboratorAddBusinessEvent event, Emitter emit) async {
    if (state.usersChecked.isEmpty) {
      AlertUtils.showMessage('Notification', 'Please select at least one user');
      return;
    }

    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    int business = instance.get<AppBloc>().state.userEntity.business;
    AddCollaboratorModel addCollaboratorModel = AddCollaboratorModel(business: business, users: state.usersChecked);
    final response = await userUseCase.addCollaborator(addCollaboratorModel);
    response.fold(
      (String message) {
        AlertUtils.showMessage('Notification', message);
        add(RefreshAddBusinessEvent());
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message, callback: () {
          add(RefreshAddBusinessEvent());
        });
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onLoadMoreAddBusiness(LoadMoreAddBusinessEvent event, Emitter emit) async {}
}
