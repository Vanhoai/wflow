import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/modules/main/data/cv/model/request_model.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/presentation/home/cv/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/cv/bloc/state.dart';

class CVBloc extends Bloc<CVEvent, CVSate> {
  final CVUseCase cvUseCase;
  CVBloc({required this.cvUseCase}) : super(const CVSate(cvEntities: [], selectCvEntities: [])) {
    on<GetMyCVEvent>(getMyCV);
    on<OnSelectedCVEVent>(selectedCV);
    on<RemoveCV>(removeCV);
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

  FutureOr<void> removeCV(RemoveCV event, Emitter<CVSate> emit) async {
    List<String> listDetele = state.selectCvEntities.map((e) => e.id.toString()).toList();
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await cvUseCase.deleteCV(RequestDeleteCV(id: listDetele));
    response.fold(
      (String messages) {
        AlertUtils.showMessage(
          'Xóa CV',
          messages
        );
        emit(state.copyWith(selectCvEntities: []));
        add(GetMyCVEvent());
      },
      (failure) {
        AlertUtils.showMessage('Xóa CV', failure.message);
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
