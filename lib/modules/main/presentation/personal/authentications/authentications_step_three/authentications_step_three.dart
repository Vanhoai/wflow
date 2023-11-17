import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/bloc/state.dart';

class AuthStepThreeScreen extends StatelessWidget {
  const AuthStepThreeScreen({super.key});
  _getImageFromCamera({required BuildContext context}) async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result == null) return;
    File file = File(result.path);
    if (context.mounted) {
      instance.get<AuthenticationsBloc>().add(StepThreeEvent(face: file));
    }
  }

  Future<void> _listener(BuildContext context, AuthenticationsState state) async {
    if (state is AuthenticationsSuccessState) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Notification',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(RouteKeys.bottomScreen, (Route<dynamic> route) => false);
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text('OK'),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
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
        body: BlocConsumer<AuthenticationsBloc, AuthenticationsState>(
          bloc: instance.get<AuthenticationsBloc>(),
          listener: _listener,
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bước 3/3', style: Theme.of(context).textTheme.displayLarge),
                        Padding(
                          padding: const EdgeInsets.only(top: 27, bottom: 12),
                          child: Text('Take your face picture', style: Theme.of(context).textTheme.displayMedium),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          height: 213,
                          decoration: BoxDecoration(color: AppColors.fade, borderRadius: BorderRadius.circular(8)),
                          child: state.face != null
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
                                  image: FileImage(state.face!))
                              : null,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (state.stepThree.messageStep == '') {
                                return const SizedBox(
                                  height: 24,
                                );
                              } else {
                                if (state.stepThree.messageStep == 'SUCCESS') {
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
                                        'Cập nhật thông tin thành công',
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
                                        state.stepThree.messageStep,
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
                              _getImageFromCamera(context: context);
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
                                  const Icon(Icons.camera_alt, color: AppColors.primary),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'CHỤP ẢNH',
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
                            backgroundColor: state.stepThree.step ? Theme.of(context).primaryColor : AppColors.fade,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: () {
                            if (state.stepThree.step) {
                              instance.get<AuthenticationsBloc>().add(FaceMatchEvent());
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
