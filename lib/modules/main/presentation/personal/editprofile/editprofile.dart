import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_from.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: const AppHeader(
        text: 'Edit Profile',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 140.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              clipBehavior: Clip.none,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImage(
                        imageUrl: 'https://cdn.hoanghamobile.com/tin-tuc/wp-content/uploads/2023/07/hinh-dep.jpg',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(32.w, -30.h, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CachedNetworkImage(
                        imageUrl: 'https://cdn.hoanghamobile.com/tin-tuc/wp-content/uploads/2023/07/hinh-dep.jpg',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    'Your name',
                    style: themeData.textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldFrom(
                      label: 'Name',
                      placeholder: 'Enter your phone',
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        size: 24,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                        child: SvgPicture.asset(
                          AppConstants.checkFill,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    TextFieldFrom(
                      label: 'Phone',
                      placeholder: 'Enter your phone',
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        size: 24,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                        child: SvgPicture.asset(AppConstants.checkFill,
                            fit: BoxFit.cover, colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn)),
                      ),
                    ),
                    TextFieldFrom(
                      label: 'Phone',
                      placeholder: 'Enter your phone',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        size: 24,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                        child: SvgPicture.asset(AppConstants.checkFill,
                            fit: BoxFit.cover, colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      onPressed: () {},
                      label: 'Edit',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
