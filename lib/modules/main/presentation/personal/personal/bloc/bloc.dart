import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/utils/secure_storage.dart';

part 'event.dart';
part 'state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalState()) {
    on<SignOutEvent>(onLogout);
  }

  void onLogout(SignOutEvent event, Emitter<PersonalState> emit) {
    instance.get<SecureStorage>().clear();
    emit(SignOutSuccess());
  }
}
