import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/arguments_model/arguments_photo.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_from.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/editprofile/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/editprofile/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/editprofile/bloc/state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage({required BuildContext context, required bool isAvatar}) async {
    dynamic file = await Navigator.of(context)
        .pushNamed(RouteKeys.photoScreen, arguments: ArgumentsPhoto(multiple: false, onlyImage: true));
    if (file == null) return;
    file as File;
    if (context.mounted) {
      if (isAvatar) {
        BlocProvider.of<EditProfileBloc>(context).add(AddAvatar(avatar: file));
      } else {
        BlocProvider.of<EditProfileBloc>(context).add(AddBackground(background: file));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(userUseCase: instance.get<UserUseCase>())..add(GetProfile()),
      child: CommonScaffold(
          hideKeyboardWhenTouchOutside: true,
          isSafe: true,
          appBar: AppHeader(
            text: Text(
              'Edit Profile',
              style: themeData.textTheme.displayMedium,
            ),
          ),
          body: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                child: InkWell(
                                  onTap: () {
                                    _pickImage(context: context, isAvatar: false);
                                  },
                                  child: Builder(
                                    builder: (context) {
                                      if (state.background != null) {
                                        return Image.file(
                                          state.background!,
                                          fit: BoxFit.cover,
                                        );
                                      }
                                      return CachedNetworkImage(
                                        imageUrl: state.userEntity.background.isEmpty
                                            ? 'https://picsum.photos/200'
                                            : state.userEntity.background,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                                      );
                                    },
                                  ),
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
                              child: InkWell(onTap: () {
                                _pickImage(context: context, isAvatar: true);
                              }, child: Builder(
                                builder: (context) {
                                  if (state.avatar != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.file(
                                        state.avatar!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: CachedNetworkImage(
                                      imageUrl: state.userEntity.avatar.isEmpty
                                          ? 'https://picsum.photos/200'
                                          : state.userEntity.avatar,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                                    ),
                                  );
                                },
                              )),
                            ),
                            8.horizontalSpace,
                            Text(
                              state.userEntity.name,
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
                                controller: context.read<EditProfileBloc>().addressController,
                                label: 'Address',
                                placeholder: 'Type your address',
                                textInputAction: TextInputAction.next,
                                prefixIcon: const Icon(
                                  Icons.location_on_sharp,
                                  size: 24,
                                ),
                              ),
                              TextFieldFrom(
                                controller: context.read<EditProfileBloc>().bioController,
                                label: 'Bio',
                                maxLines: 5,
                                placeholder: 'Type your bio',
                                textInputAction: TextInputAction.next,
                                contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                              ),
                              const SizedBox(height: 24),
                              PrimaryButton(
                                onPressed: () {
                                  context.read<EditProfileBloc>().add(EditProfile());
                                },
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
            },
          )),
    );
  }
}
