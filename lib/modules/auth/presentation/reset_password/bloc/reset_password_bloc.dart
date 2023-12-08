import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  AuthUseCase authUseCase;

  ResetPasswordBloc({required this.authUseCase}) : super(ResetPasswordInitial()) {
    on<ResetPasswordSubmitEvent>(onResetPassword);
  }

  Future<void> onResetPassword(ResetPasswordSubmitEvent event, Emitter<ResetPasswordState> emit) async {
    try {
      instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

      if (event.password != event.confirmPassword) {
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification') ?? 'Notification',
            instance.get<AppLocalization>().translate('errorConfirmPassword') ?? 'Error confirm password');
        instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
        return;
      }

      final response =
          await authUseCase.resetPassword(username: event.username, password: event.password, type: event.type);

      response.fold((String l) {
        emit(ResetPasswordSuccess(message: l));
      }, (Failure l) {
        emit(ResetPasswordFailure(message: l.message));
      });

      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());

      emit(ResetPasswordInitial());
    } catch (e) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification') ?? 'Notification',
          instance.get<AppLocalization>().translate('errorResetPassword') ?? 'Error reset password');
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }
}
