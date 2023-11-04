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

  RegisterBloc({required this.authUseCase}) : super(RegisterState.createEmpty()) {
    on<RegisterTypeEvent>(onRegisterType);
    on<RegisterErrorEvent>(onRegisterError);
  }

  Future<void> onRegisterType(RegisterTypeEvent registerEvent, Emitter<RegisterState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final request = AuthNormalRegisterRequest(
        username: registerEvent.username,
        password: registerEvent.password,
        type: registerEvent.type,
      );

      final result = await authUseCase.register(request);
      result.fold((String l) {
        emit(RegisterEmailSuccessState(message: l));
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
}
