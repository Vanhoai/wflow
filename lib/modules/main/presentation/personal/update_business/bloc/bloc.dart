import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/modules/main/data/company/request/update_business_rqst.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/personal/update_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/update_business/bloc/state.dart';

class UpdateBusinessBloc extends Bloc<UpdateBusinessEvent, UpdateBusinessState> {
  final CompanyUseCase companyUseCase;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController overviewController = TextEditingController();
  final Dio dio = Dio();
  final API_KEY = "kI62j88hI1ZadFFYnwOak9CLgpYQaumGrAJKY7Ub";
  UpdateBusinessBloc({required this.companyUseCase})
      : super(UpdateBusinessState(
            companyEntity: CompanyEntity.createEmpty(), avatar: null, background: null, location: const [])) {
    on<GetProfile>(getProfile);
    on<AddAvatar>(addAvatar);
    on<AddBackground>(addBackground);
    on<UpdateBusiness>(updateBusiness);
    on<SearchLocation>(searchLocation);
    on<OnSearchLocation>(onSearchLocation);
    on<OnSelect>(onSelect);
  }

  FutureOr<void> getProfile(GetProfile event, Emitter<UpdateBusinessState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await companyUseCase.myCompany();

    response.fold(
      (CompanyEntity companyEntity) {
        overviewController.text = companyEntity.overview;
        addressController.text = companyEntity.address;
        emit(state.copyWith(companyEntity: companyEntity));
      },
      (failure) {
        AlertUtils.showMessage('Close Contract', failure.message);
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr<void> addAvatar(AddAvatar event, Emitter<UpdateBusinessState> emit) {
    emit(state.copyWith(avatar: event.avatar));
  }

  FutureOr<void> addBackground(AddBackground event, Emitter<UpdateBusinessState> emit) {
    emit(state.copyWith(background: event.background));
  }

  FutureOr<void> updateBusiness(UpdateBusiness event, Emitter<UpdateBusinessState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await companyUseCase.updateBusiness(
        request: RequestUpdateBusiness(logo: state.avatar, background: state.background, companyEntity: state.companyEntity.copyWith(overview: overviewController.text)));
    response.fold(
      (String messages) {
        AlertUtils.showMessage(
          'Update Business',
          messages,
          callback: () {
            instance.get<NavigationService>().pushNamedAndRemoveUntil(RouteKeys.bottomScreen);
          },
        );
      },
      (failure) {
        AlertUtils.showMessage('Update Business', failure.message);
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  @override
  Future<void> close() {
    addressController.dispose();
    overviewController.dispose();
    return super.close();
  }

  FutureOr<void> searchLocation(SearchLocation event, Emitter<UpdateBusinessState> emit) async {
    emit(state.copyWith(listLocationShow: false));
    final respone =
        await dio.get("https://rsapi.goong.io/geocode?address=${addressController.text}&api_key=${API_KEY}");
    List<dynamic> list = respone.data["results"];
    dynamic lat = list[0]["geometry"]["location"]["lat"];
    dynamic lng = list[0]["geometry"]["location"]["lng"];
    print(lng);

    emit(state.copyWith(companyEntity: state.companyEntity.copyWith(latitude: lat, longitude: lng,address:addressController.text )));
  }

  FutureOr<void> onSearchLocation(OnSearchLocation event, Emitter<UpdateBusinessState> emit) async {
    if (event.show) {
      emit(state.copyWith(listLocationShow: event.show));
      final respone =
          await dio.get("https://rsapi.goong.io/Place/AutoComplete?api_key=${API_KEY}&input=${addressController.text}");
      if (respone.data["predictions"] != null) {
        List<dynamic> list = respone.data["predictions"];
        List<String> locations = list.map((e) => e["description"].toString()).toList();
        emit(state.copyWith(location: locations));
      }
    } else {
      emit(state.copyWith(listLocationShow: event.show));
    }
  }

  FutureOr<void> onSelect(OnSelect event, Emitter<UpdateBusinessState> emit) {
    emit(state.copyWith(listLocationShow: false));
    addressController.text = event.location;
    add(SearchLocation());
  }
}
