import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/presentation/home/cv/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/cv/bloc/state.dart';

class CVBloc extends Bloc<CVEvent, CVSate> {
  final CVUseCase cvUseCase;
  CVBloc({required this.cvUseCase}) : super(const CVSate(cvEntities: [], selectCvEntities: [])) {
    on<GetMyCVEvent>(getMyCV);
    on<OnSelectedCVEVent>(selectedCV);
  }

  FutureOr<void> getMyCV(GetMyCVEvent event, Emitter<CVSate> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await cvUseCase.getMyCV();

    emit(state.copyWith(isLoading: false, cvEntities: response));
  }

  FutureOr<void> selectedCV(OnSelectedCVEVent event, Emitter<CVSate> emit) {
    var newListSelect = [...state.selectCvEntities];
    if (!event.state) {
      var index = state.cvEntities.indexWhere((element) => element.id == event.id);
      newListSelect.add(state.cvEntities[index]);
    } else {
      var index = newListSelect.indexWhere((element) => element.id == event.id);
      newListSelect.removeAt(index);
    }
    emit(state.copyWith(selectCvEntities: newListSelect));
  }
}
