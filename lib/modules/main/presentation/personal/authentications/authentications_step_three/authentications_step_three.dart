import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';

class AuthStepThreeScreen extends StatelessWidget {
  const AuthStepThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text('Bước 3/3',
                      style: Theme.of(context).textTheme.displayLarge),
                  Padding(
                      padding: const EdgeInsets.only(top: 27, bottom: 12),
                      child: Text('Chụp ảnh chân dung',
                          style: Theme.of(context).textTheme.displayMedium)),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(height: 1.4),
                        children: [
                          TextSpan(
                              text:
                                  'Ảnh chụp cần phải rõ ràng, không bị chói hoặc mờ và phải',
                              style: Theme.of(context).textTheme.bodyLarge),
                          TextSpan(
                              text: ' khớp với ảnh trên giấy tờ tùy thân',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.primary))
                        ]),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    height: 288,
                    decoration: BoxDecoration(
                        color: AppColors.fade,
                        borderRadius: BorderRadius.circular(8)),
                    child: false
                        ? Image(
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: Loading(
                                height: 24,
                                width: 24,
                              ));
                            },
                            fit: BoxFit.cover,
                            image: FileImage(File('')))
                        : null,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int status = 1;
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: AppColors.greenColor),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: AppColors.redColor),
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
                        print('Lấy hình');
                      },
                      child: Ink(
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 7, right: 13),
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
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primary, BlendMode.srcIn),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'CHỤP ẢNH',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.primary),
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
                      disabledBackgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    onPressed: () {},
                    child: const Text('Xác nhận',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ))),
    );
  }
}
