import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class AppLoadingBloc extends Bloc<AppLoadingEvent, AppLoadingState> {
  AppLoadingBloc() : super(HideLoadingState()) {
    on<AppShowLoadingEvent>(onShowLoading);
    on<AppHideLoadingEvent>(onHideLoading);
  }

  void onShowLoading(AppShowLoadingEvent event, Emitter<AppLoadingState> emit) {
    emit(ShowLoadingState());
  }

  void onHideLoading(AppHideLoadingEvent event, Emitter<AppLoadingState> emit) {
    emit(HideLoadingState());
  }
}
