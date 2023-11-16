import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class AppLoadingBloc extends Bloc<AppLoadingEvent, AppLoadingState> {
  AppLoadingBloc() : super(AppHideLoadingState()) {
    on<AppShowLoadingEvent>(onShowLoading);
    on<AppHideLoadingEvent>(onHideLoading);
  }

  void onShowLoading(AppShowLoadingEvent event, Emitter<AppLoadingState> emit) {
    emit(AppShowLoadingState(message: event.message));
  }

  void onHideLoading(AppHideLoadingEvent event, Emitter<AppLoadingState> emit) {
    emit(AppHideLoadingState());
  }
}
