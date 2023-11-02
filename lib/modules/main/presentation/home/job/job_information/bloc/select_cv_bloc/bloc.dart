import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/select_cv_bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/select_cv_bloc/state.dart';

class SelectCVBloc extends Bloc<SelectCVEvent, SelectCVSate> {
  final CVUseCase cvUseCase;
  SelectCVBloc({required this.cvUseCase}) : super(const SelectCVSate(cvEntities: [], selectID: 0)) {
    on<GetMyCVEvent>(getMyCV);
    on<OnSelectedCVEVent>(selectedCV);
  }

  FutureOr<void> getMyCV(GetMyCVEvent event, Emitter<SelectCVSate> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await cvUseCase.getMyCV();
    num selectID = 0;
    if (response.isNotEmpty) {
      selectID = response[0].id;
    }
    emit(state.copyWith(isLoading: false, cvEntities: response, selectID: selectID));
  }

  FutureOr<void> selectedCV(OnSelectedCVEVent event, Emitter<SelectCVSate> emit) {
    print("hello");
    emit(state.copyWith(selectID: event.id));
  }
}
