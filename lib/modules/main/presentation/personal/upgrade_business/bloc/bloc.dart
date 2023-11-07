import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/company/request/update_business_rqst.dart';
import 'package:wflow/modules/main/data/media/models/upload_file_rqst.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/domain/media/entities/file_entity.dart';
import 'package:wflow/modules/main/domain/media/media_usecase.dart';

part 'event.dart';
part 'state.dart';

class UpgradeBusinessBloc extends Bloc<UpgradeBusinessEvent, UpgradeBusinessState> {
  final MediaUseCase mediaUseCase;
  final CompanyUseCase companyUseCase;

  UpgradeBusinessBloc({
    required this.mediaUseCase,
    required this.companyUseCase,
  }) : super(UpgradeBusinessState()) {
    on<UpgradeBusinessSubmitEvent>(onSubmit);
  }

  FutureOr<void> onSubmit(UpgradeBusinessSubmitEvent event, Emitter<UpgradeBusinessState> emit) async {
    final isVerify = instance.get<AppBloc>().state.userEntity.isVerify;
    final context = instance.get<NavigationService>().navigatorKey.currentContext;

    if (!isVerify) {
      AlertUtils.showMessage(
        'Notification',
        'Please verify your email before upgrade business',
        callback: () {
          print('callback');
          Navigator.of(context!).pushNamed(RouteKeys.auStepOneScreen);
        },
      );
      return;
    }

    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final responseLogo = await mediaUseCase.uploadFile(
      request: UploadFileRequest(folder: 'Business', file: event.logo),
    );

    responseLogo.fold(
      (FileEntity fileEntity) {
        upgradeBusiness(
          UpgradeBusinessRequest(
            email: event.email,
            phone: event.phone,
            name: event.name,
            address: 'TTH20, quận 12, TP HCM',
            logo: fileEntity.id,
            overview: event.overview,
            longitude: 106.665290,
            latitude: 10.852330,
          ),
          emit,
        );
      },
      (Failure failure) {
        instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
        AlertUtils.showMessage('Notification', failure.message);
        emit(UpgradeBusinessState());
      },
    );
  }

  FutureOr<void> upgradeBusiness(UpgradeBusinessRequest request, Emitter<UpgradeBusinessState> emit) async {
    // init payment sheet
    final paymentSheet =
        await Stripe.instance.initPaymentSheet(paymentSheetParameters: const SetupPaymentSheetParameters());

    final response = await companyUseCase.upgradeBusiness(request: request);
    response.fold(
      (String message) {
        AlertUtils.showMessage('Notification', message, callback: () {
          instance.get<NavigationService>().navigatorKey.currentState!.pop();
        });
      },
      (Failure failure) {
        instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
        AlertUtils.showMessage('Notification', failure.message);
        emit(UpgradeBusinessState());
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
