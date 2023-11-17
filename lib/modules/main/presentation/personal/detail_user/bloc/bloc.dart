import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/detail_user/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/detail_user/bloc/state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  final UserUseCase userUseCase;
  DetailUserBloc({required this.userUseCase}) : super(DetailUserState()) {
    on<GetUserInfo>(getUserInfo);
  }

  FutureOr<void> getUserInfo(GetUserInfo event, Emitter<DetailUserState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await userUseCase.findUserByID(id: '${event.id}');

    response.fold(
      (UserEntity userEntity) {
        emit(GetDetailUserSuccess(userEntity: userEntity));
      },
      (failure) {
        AlertUtils.showMessage('Get user info', failure.message);
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
