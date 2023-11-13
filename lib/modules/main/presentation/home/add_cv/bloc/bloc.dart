import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/cv/model/request_model.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

part 'event.dart';
part 'state.dart';

class AddCVBloc extends Bloc<AddCVEvent, AddCVState> {
  final CVUseCase cvUseCase;
  AddCVBloc({required this.cvUseCase}) : super(const AddCVState()) {
    on<AddMyCVEvent>(addMyCV);
  }

  FutureOr<void> addMyCV(AddMyCVEvent event, Emitter<AddCVState> emit) async {
    emit(state.copyWith(isLoading: true));
    final cv = await cvUseCase.addCV(event.requestAddCV);
    cv.fold((UserEntity left) {
      emit(const AddCVSuccessState());
    }, (Failure right) {
      emit(const AddCVFailureState());
      emit(const AddCVState());
    });
  }
}
