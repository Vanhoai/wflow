import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/state.dart';

class RemoveCollaboratorBloc extends Bloc<RemoveCollaboratorEvent, RemoveCollaboratorState> {
  final UserUseCase userUseCase;

  RemoveCollaboratorBloc({required this.userUseCase})
      : super(RemoveCollaboratorState(meta: Meta.empty(), users: const [], usersChecked: const [])) {
    on<GetAllCollaboratorEvent>(onGetAllCollaborator);
    on<LoadMoreCollaboratorEvent>(onLoadMoreCollaborator);
    on<CheckedCollaboratorEvent>(onCheckedCollaborator);
    on<DeleteCollaboratorEvent>(onDeleteCollaborator);
  }

  Future<void> onGetAllCollaborator(GetAllCollaboratorEvent event, Emitter emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final result = await userUseCase.getAllCollaborator(
      const GetAllCollaboratorModel(),
    );

    result.fold(
      (HttpResponseWithPagination<UserEntity> users) {
        emit(state.copyWith(users: users.data, meta: users.meta));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future<void> onLoadMoreCollaborator(LoadMoreCollaboratorEvent event, Emitter emit) async {}

  Future<void> onCheckedCollaborator(CheckedCollaboratorEvent event, Emitter emit) async {
    List<int> newUsersChecked = [];
    if (event.isChecked) {
      newUsersChecked = [...state.usersChecked, event.id];
    } else {
      newUsersChecked = [...state.usersChecked];
      newUsersChecked.remove(event.id);
    }

    emit(state.copyWith(usersChecked: newUsersChecked));
  }

  Future<void> onDeleteCollaborator(DeleteCollaboratorEvent event, Emitter emit) async {
    if (state.usersChecked.isEmpty) {
      AlertUtils.showMessage('Notification', 'Please select at least one collaborator');
      return;
    }

    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    int business = instance.get<AppBloc>().state.userEntity.business;

    final response = await userUseCase.removeCollaborator(
      RemoveCollaboratorModel(business: business, users: state.usersChecked),
    );

    response.fold(
      (String message) {
        AlertUtils.showMessage('Notification', message);
        add(GetAllCollaboratorEvent());
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
