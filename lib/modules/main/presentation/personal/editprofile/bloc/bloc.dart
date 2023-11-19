import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/modules/main/data/user/models/request/update_profile.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/editprofile/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/editprofile/bloc/state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserUseCase userUseCase;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  EditProfileBloc({required this.userUseCase})
      : super(EditProfileState(userEntity: instance.get<AppBloc>().state.userEntity, avatar: null, background: null)) {
    on<GetProfile>(getProfile);
    on<AddAvatar>(addAvatar);
    on<AddBackground>(addBackground);
    on<EditProfile>(editProfile);
  }

  FutureOr<void> getProfile(GetProfile event, Emitter<EditProfileState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await userUseCase.findUserByID(id: '${instance.get<AppBloc>().state.userEntity.id}');

    response.fold(
      (UserEntity userEntity) {
        addressController.text = userEntity.address;
        bioController.text = userEntity.bio;
        emit(state.copyWith(userEntity: userEntity));
      },
      (failure) {
        AlertUtils.showMessage('Close Contract', failure.message);
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr<void> addAvatar(AddAvatar event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(avatar: event.avatar));
  }

  FutureOr<void> addBackground(AddBackground event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(background: event.background));
  }

  FutureOr<void> editProfile(EditProfile event, Emitter<EditProfileState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await userUseCase.updateProfile(
        request: RequestUpdateProfile(
      avatar: state.avatar,
      background: state.background,
      address: addressController.text,
      bio: bioController.text,
      dob: int.parse(instance.get<AppBloc>().state.userEntity.dob),
      age: instance.get<AppBloc>().state.userEntity.age,
    ));
    response.fold(
      (String messages) {
        AlertUtils.showMessage(
          'Update profile',
          messages,
          callback: () {
            instance.get<NavigationService>().pushNamedAndRemoveUntil(RouteKeys.bottomScreen);
          },
        );
      },
      (failure) {
        AlertUtils.showMessage('Update profile', failure.message);
      },
    );
    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  @override
  Future<void> close() {
    addressController.dispose();
    bioController.dispose();
    return super.close();
  }
}
