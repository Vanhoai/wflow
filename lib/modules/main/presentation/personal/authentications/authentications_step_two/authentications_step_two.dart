import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/arguments_model/arguments_photo.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/state.dart';

class AuthStepTwoScreen extends StatelessWidget {
  const AuthStepTwoScreen({super.key});
  Future<void> _pickImage({required BuildContext context}) async {
    dynamic file = await Navigator.of(context)
        .pushNamed(RouteKeys.photoScreen, arguments: ArgumentsPhoto(multiple: false, onlyImage: true));
    if (file == null) return;
    file as File;
    if (context.mounted) {
      instance.get<AuthenticationsBloc>().add(StepTwoEvent(backID: file));
    }
  }

  _getImageFromCamera({required BuildContext context}) async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result == null) return;
    File file = File(result.path);
    if (context.mounted) {
      instance.get<AuthenticationsBloc>().add(StepTwoEvent(backID: file));
    }
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).copyWith(primaryColor: AppColors.blueColor);
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
        appBar: AppHeader(
          text: Text(
            'Verify Account',
            style: themeData.textTheme.displayMedium,
          ),
        ),
        body: BlocBuilder<AuthenticationsBloc, AuthenticationsState>(
          bloc: instance.get<AuthenticationsBloc>(),
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bước 2/3', style: Theme.of(context).textTheme.displayLarge),
                        Padding(
                          padding: const EdgeInsets.only(top: 27, bottom: 12),
                          child:
                              Text('Chụp sau trước giấy tờ tùy thân', style: Theme.of(context).textTheme.displayMedium),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          height: 213,
                          decoration: BoxDecoration(color: AppColors.fade, borderRadius: BorderRadius.circular(8)),
                          child: state.backID != null
                              ? Image(
                                  loadingBuilder:
                                      (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: Loading(
                                      height: 24,
                                      width: 24,
                                    ));
                                  },
                                  fit: BoxFit.cover,
                                  image: FileImage(state.backID!))
                              : null,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (state.stepTwo.messageStep == '') {
                                return const SizedBox(
                                  height: 24,
                                );
                              } else {
                                if (state.stepTwo.messageStep == 'SUCCESS') {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: AppColors.greenColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Ảnh hợp lệ',
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )
                                    ],
                                  );
                                } else {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cancel,
                                        color: AppColors.redColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        state.stepTwo.messageStep,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      )
                                    ],
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {
                              _pickImage(context: context);
                            },
                            child: Ink(
                              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 7, right: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.primary.withAlpha(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.image, color: AppColors.primary),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'CHỌN ẢNH',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            maximumSize: const Size(double.infinity, 50),
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: state.stepTwo.step ? Theme.of(context).primaryColor : AppColors.fade,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: () {
                            if (state.stepTwo.step) {
                              Navigator.of(context).pushNamed(RouteKeys.auStepThreeScreen);
                            }
                          },
                          child: const Text('Tiếp tục', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        const SizedBox(
                          height: 24,
                        )
                      ],
                    )),
                Positioned(
                  child: Visibility(
                    visible: state.isLoading,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black12,
                      child: const Loading(),
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
