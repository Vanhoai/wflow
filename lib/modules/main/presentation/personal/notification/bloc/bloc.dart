import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/modules/main/domain/user/entities/notification_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';

part 'event.dart';
part 'state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final UserUseCase userUseCase;

  NotificationBloc({required this.userUseCase}) : super(const NotificationState(notifications: [])) {
    on<GetNotification>(_getNotification);
    on<RefreshNotification>(_refreshNotification);
  }

  Future<void> _getNotification(GetNotification event, Emitter<NotificationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final response = await userUseCase.notification(page: event.page, pageSize: event.pageSize, search: '');
      response.fold(
        (data) {
          emit(state.copyWith(notifications: data.data));
        },
        (error) {
          emit(state.copyWith(notifications: []));
        },
      );
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future<void> _refreshNotification(RefreshNotification event, Emitter<NotificationState> emit) async {
    add(const GetNotification(page: 1, pageSize: 1000));
  }
}
