import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';

part 'event.dart';
part 'state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final AuthUseCase authUseCase;

  CreateAccountBloc({required this.authUseCase}) : super(const CreateAccountState());
}
