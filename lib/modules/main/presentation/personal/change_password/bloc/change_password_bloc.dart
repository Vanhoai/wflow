import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthUseCase authUseCase;

  ChangePasswordBloc({required this.authUseCase}) : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitEvent>(onChangePasswordSubmitEvent);
    on<ChangePasswordInitialEvent>((event, emit) {
      emit(ChangePasswordInitial());
    });
  }

  Future onChangePasswordSubmitEvent(ChangePasswordSubmitEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
      final response =
          await authUseCase.changeNewPassword(oldPassword: event.oldPassword, newPassword: event.newPassword);
      response.fold(
        (String success) {
          emit(ChangePasswordSuccess(message: success.toString()));
        },
        (Failure failure) {
          emit(ChangePasswordFailure(message: failure.message.toString()));
        },
      );
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
    } catch (e) {
      AlertUtils.showMessage('Notification', e.toString());
    } finally {
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }
}
