import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/modules/auth/data/models/request_model.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUseCase authUseCase;

  RegisterBloc({required this.authUseCase}) : super(const RegisterInitialState()) {
    on<RegisterTypeEvent>(onRegisterType);
    on<RegisterErrorEvent>(onRegisterError);
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
      print(exception);

      add(const RegisterErrorEvent(message: 'Server error'));
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future<void> onRegisterError(RegisterErrorEvent registerEvent, Emitter<RegisterState> emit) async {
    emit(RegisterErrorState(message: registerEvent.message));
  }
}
