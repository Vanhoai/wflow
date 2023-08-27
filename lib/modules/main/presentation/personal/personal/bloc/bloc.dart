import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalState()) {
    on<SignOutEvent>(onLogout);
  }

  void onLogout(SignOutEvent event, Emitter<PersonalState> emit) {
    // instance.get<SecureStorage>().clear();
    emit(SignOutSuccess());
  }
}
