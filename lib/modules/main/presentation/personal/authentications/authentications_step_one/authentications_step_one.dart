import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/dialog_pick_image.dart';

class AuthStepOneScreen extends StatelessWidget {
  const AuthStepOneScreen({super.key});

  Future<void> _pickImage({required BuildContext context}) async {
    dynamic? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => DialogPickImage(
        pickImageFromCamera: () => Navigator.pop(context, ImageSource.camera),
        pickImageFromGallery: () => null,
      ),
    );

    if (source != null) {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).copyWith(primaryColor: AppColors.blueColor);
    return SafeArea(
      child: Scaffold(
          appBar: const AppHeader(
            text: 'Verify account',
          ),
          body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bước 1/3', style: Theme.of(context).textTheme.displayLarge),
                  Padding(
                    padding: const EdgeInsets.only(top: 27, bottom: 12),
                    child: Text('Chụp mặt trước giấy tờ tùy thân', style: Theme.of(context).textTheme.displayMedium),
                  ),
                  Text(
                    'Các loại giấy tờ hợp lệ: Căn cước công dân, chứng minh nhân dân.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 42),
                  Container(
                    alignment: Alignment.center,
                    height: 213,
                    decoration: BoxDecoration(color: AppColors.fade, borderRadius: BorderRadius.circular(8)),
                    child: null,
                    // child: false
                    //     ? Image(
                    //         loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    //           if (loadingProgress == null) return child;
                    //           return const Center(
                    //               child: Loading(
                    //             height: 24,
                    //             width: 24,
                    //           ));
                    //         },
                    //         fit: BoxFit.cover,
                    //         image: FileImage(File('')))
                    //     : null,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int status = 0;
                        switch (status) {
                          case 0:
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
                          case 1:
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
                                  'Ảnh không hợp lệ',
                                  style: Theme.of(context).textTheme.displayMedium,
                                )
                              ],
                            );
                          default:
                            return const SizedBox(
                              height: 24,
                            );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
                        print('Lấy hình');
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
                            SvgPicture.asset(
                              AppConstants.camera,
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                            ),
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
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteKeys.auStepTwoScreen);
                    },
                    child: const Text('Tiếp tục', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ))),
    );
  }
}
