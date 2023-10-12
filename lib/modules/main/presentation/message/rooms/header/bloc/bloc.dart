

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/state.dart';

class HeaderRoomsBloc extends Bloc<HeaderRoomsEvent,HeaderRoomState>{
  HeaderRoomsBloc(): super(const HeaderRoomState()){
   on<ShowSearchEvent>(showSearch);
  }

  FutureOr<void> showSearch(ShowSearchEvent event, Emitter<HeaderRoomState> emit) {
    print(event.show);
    emit(state.copyWith(showSearch: event.show));
  }
}