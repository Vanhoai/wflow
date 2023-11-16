import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/modules/main/data/report/models/request_model.dart';
import 'package:wflow/modules/main/domain/report/entities/report_entity.dart';
import 'package:wflow/modules/main/domain/report/report_usecase.dart';
import 'package:wflow/modules/main/presentation/home/report/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/report/bloc/state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportUseCase reportUseCase;
  ReportBloc({required this.reportUseCase}) : super(const ReportState(files: [])) {
    on<AddImageEvent>(addImage);
    on<Submit>(submit);
  }

  FutureOr<void> addImage(AddImageEvent event, Emitter<ReportState> emit) {
    emit(state.copyWith(files: [...state.files, ...event.files]));
  }

  FutureOr<void> submit(Submit event, Emitter<ReportState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await reportUseCase.createReport(
        RequestReportModel(files: state.files, content: event.content, target: event.target, type: event.type));
    response.fold(
      (ReportEntity left) {
        AlertUtils.showMessage(
          'Close Report',
          'Thanks your report!',
          callback: () {
            instance.get<NavigationService>().popUntil(1);
          },
        );
      },
      (failure) {
        AlertUtils.showMessage('Close Contract', failure.message);
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
