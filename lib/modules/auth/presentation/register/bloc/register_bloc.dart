import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/auth/data/models/auth_google_model.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUseCase authUseCase;

  RegisterBloc({required this.authUseCase}) : super(const RegisterInitialState()) {
    on<RegisterTypeEvent>(onRegisterType);
    on<RegisterErrorEvent>(onRegisterError);
    on<RegisterWithGoogleEvent>(onRegisterWithGoogle);
  }

  Future<void> onRegisterType(RegisterTypeEvent registerEvent, Emitter<RegisterState> emit) async {
    try {
      emit(const RegisterInitialState());
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final request = AuthNormalRegisterRequest(
        username: registerEvent.username,
        password: registerEvent.password,
        type: registerEvent.type,
      );

      final result = await authUseCase.register(request);
      result.fold((String l) {
        if (registerEvent.type == 'phone') {
          emit(const RegisterPhoneSuccessState(message: 'Please check your phone for OTP code'));
        } else {
          emit(const RegisterEmailSuccessState(message: 'Please check your email for OTP code'));
        }
        return l;
      }, (r) {
        add(RegisterErrorEvent(message: r.message.toString()));
        return r;
      });
    } catch (exception) {
      add(RegisterErrorEvent(message: exception.toString()));
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future<void> onRegisterError(RegisterErrorEvent registerEvent, Emitter<RegisterState> emit) async {
    emit(RegisterErrorState(message: registerEvent.message));
  }

  Future<void> onRegisterWithGoogle(RegisterWithGoogleEvent event, Emitter<RegisterState> emit) async {
    String idToken = await FirebaseAuthService.signInWithGoogle();
    if (idToken.isEmpty) {
      AlertUtils.showMessage('Notification', "Can't get IDToken from Google");
      return;
    }

    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await authUseCase.registerWithGoogle(
      request: AuthWithGoogleModel(idToken: idToken, deviceToken: '', type: 'sign-up'),
    );

    response.fold(
      (String message) {
        AlertUtils.showMessage(
          'Notification',
          message,
          callback: () {
            instance.get<NavigationService>().pop();
          },
        );
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
