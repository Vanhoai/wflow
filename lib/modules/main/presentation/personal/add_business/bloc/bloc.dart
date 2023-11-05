import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/configuration/environment.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/state.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';

class AddBusinessBloc extends Bloc<AddBusinessEvent, AddBusinessState> {
  final UserUseCase userUseCase;
  final int defaultPage = 1;
  final int defaultPageSize = 3;
  final String defaultSearch = '';

  AddBusinessBloc({required this.userUseCase})
      : super(const AddBusinessState()) {
    on<InitAddBusinessEvent>(onInitAddBusiness);
    on<SearchAddBusinessEvent>(onSearchAddBusiness);
    on<ChangedIconClearAddBusinessEvent>(onChangedIconClearAddBusiness);
    on<ScrollAddBusinessEvent>(onScrollAddBusiness);
    on<RefreshAddBusinessEvent>(onRefreshAddBusiness);
    on<UserCheckedAddBusinessEvent>(onUserCheckedAddBusiness);
    on<AddCollaboratorAddBusinessEvent>(onAddCollaboratorAddBusiness);
    on<LoadMoreAddBusinessEvent>(onLoadMoreAddBusiness);
  }

  Future<void> onInitAddBusiness(
      InitAddBusinessEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    GetUserNotBusinessModel getUserNotBusinessModel =
        const GetUserNotBusinessModel();
    final List<UserEntity> users =
        await userUseCase.getUsersNotBusiness(getUserNotBusinessModel);
    emit(state.copyWith(users: users));

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onSearchAddBusiness(
      SearchAddBusinessEvent event, Emitter emit) async {
    GetUserNotBusinessModel getUserNotBusinessModel =
        GetUserNotBusinessModel(search: event.txtSearch);
    final List<UserEntity> users =
        await userUseCase.getUsersNotBusiness(getUserNotBusinessModel);

    emit(state.copyWith(users: users, page: 1));
  }

  Future<void> onChangedIconClearAddBusiness(
      ChangedIconClearAddBusinessEvent event, Emitter emit) async {
    emit(state.copyWith(
        isHiddenSuffixIcon: event.txtSearch == '', txtSearch: event.txtSearch));
  }

  Future<void> onScrollAddBusiness(
      ScrollAddBusinessEvent event, Emitter emit) async {
    GetUserNotBusinessModel getUserNotBusinessModel =
        GetUserNotBusinessModel(page: state.page + 1, search: state.txtSearch);
    final List<UserEntity> users =
        await userUseCase.getUsersNotBusiness(getUserNotBusinessModel);

    List<UserEntity> newUsers = [
      ...state.users.map((e) => UserEntity.fromJson(e.toJson())),
      ...users.map((e) => UserEntity.fromJson(e.toJson())),
    ];

    emit(state.copyWith(
        users: newUsers, page: state.page + 1, isLoadMore: false));
  }

  Future<void> onRefreshAddBusiness(
      RefreshAddBusinessEvent event, Emitter emit) async {
    GetUserNotBusinessModel getUserNotBusinessModel =
        GetUserNotBusinessModel(search: state.txtSearch);
    final List<UserEntity> users =
        await userUseCase.getUsersNotBusiness(getUserNotBusinessModel);

    emit(state.copyWith(users: users));
  }

  Future<void> onUserCheckedAddBusiness(
      UserCheckedAddBusinessEvent event, Emitter emit) async {
    List<int> usersChecked = [...state.usersChecked];
    if (event.isChecked) {
      usersChecked.add(event.id);
    } else {
      usersChecked.remove(event.id);
    }

    emit(state.copyWith(usersChecked: usersChecked));
  }

  Future<void> onAddCollaboratorAddBusiness(
      AddCollaboratorAddBusinessEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    String accessToken = instance.get<AppBloc>().state.authEntity.accessToken;
    final jwt = JWT.verify(
        accessToken, SecretKey(EnvironmentConfiguration.accessTokenSecret));
    final business = jwt.payload['business'];

    AddCollaboratorModel addCollaboratorModel =
        AddCollaboratorModel(business: business, users: state.usersChecked);

    final bool result = await userUseCase.addCollaborator(addCollaboratorModel);

    if (result) {
      GetUserNotBusinessModel getUserNotBusinessModel =
          const GetUserNotBusinessModel();
      final List<UserEntity> users =
          await userUseCase.getUsersNotBusiness(getUserNotBusinessModel);

      emit(state.copyWith(users: users, usersChecked: []));
    } else {
      emit(state.copyWith());
    }
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onLoadMoreAddBusiness(
      LoadMoreAddBusinessEvent event, Emitter emit) async {
    emit(state.copyWith(isLoadMore: true));
  }
}
