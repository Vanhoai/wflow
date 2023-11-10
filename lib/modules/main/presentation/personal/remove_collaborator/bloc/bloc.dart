import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/configuration/environment.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/state.dart';

class RemoveCollaboratorBloc
    extends Bloc<RemoveCollaboratorEvent, RemoveCollaboratorState> {
  final UserUseCase userUseCase;
  RemoveCollaboratorBloc({required this.userUseCase})
      : super(const RemoveCollaboratorState()) {
    on<GetAllCollaboratorEvent>(onGetAllCollaborator);
    on<ScrollCollaboratorEvent>(onScrollCollaborator);
    on<LoadMoreCollaboratorEvent>(onLoadMorelCollaborator);
    on<CheckedCollaboratorEvent>(onCheckedCollaborator);
    on<DeleteCollaboratorEvent>(onDeleteCollaborator);
  }

  Future<void> onGetAllCollaborator(
      GetAllCollaboratorEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final List<UserEntity> users =
        await userUseCase.getAllCollaborator(const GetAllCollaboratorModel());

    print('my log');
    emit(state.copyWith(users: users));
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onScrollCollaborator(
      ScrollCollaboratorEvent event, Emitter emit) async {
    final List<UserEntity> users = await userUseCase
        .getAllCollaborator(GetAllCollaboratorModel(page: state.page + 1));

    final List<UserEntity> newUsers = [
      ...state.users.map((e) => UserEntity.fromJson(e.toJson())),
      ...users.map((e) => UserEntity.fromJson(e.toJson()))
    ];

    emit(state.copyWith(
      users: newUsers,
      page: state.page + 1,
      isLoadMore: false,
    ));
  }

  Future<void> onLoadMorelCollaborator(
      LoadMoreCollaboratorEvent event, Emitter emit) async {
    emit(state.copyWith(isLoadMore: event.isLoadMore));
  }

  Future<void> onCheckedCollaborator(
      CheckedCollaboratorEvent event, Emitter emit) async {
    List<int> newUsersChecked = [];
    if (event.isChecked) {
      newUsersChecked = [...state.usersChecked, event.id];
    } else {
      newUsersChecked = [...state.usersChecked];
      newUsersChecked.remove(event.id);
    }

    emit(state.copyWith(usersChecked: newUsersChecked));
  }

  Future<void> onDeleteCollaborator(
      DeleteCollaboratorEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    String accessToken = instance.get<AppBloc>().state.authEntity.accessToken;
    final jwt = JWT.verify(
        accessToken, SecretKey(EnvironmentConfiguration.accessTokenSecret));
    final business = jwt.payload['business'];
    final result = await userUseCase.removeCollaborator(
        RemoveCollaboratorModel(business: business, users: state.usersChecked));
    if (result) {
      add(GetAllCollaboratorEvent());
      emit(state.copyWith(usersChecked: []));
    } else {
      emit(state.copyWith());
    }
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
