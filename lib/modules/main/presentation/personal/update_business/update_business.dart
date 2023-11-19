import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/arguments_model/arguments_photo.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/utils/search.utils.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_from.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/update_business/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/update_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/update_business/bloc/state.dart';
import 'package:wflow/modules/main/presentation/personal/update_business/widget/location.dart';

class UpdateBusinessScreen extends StatefulWidget {
  const UpdateBusinessScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateBusinessScreenState();
}

class _UpdateBusinessScreenState extends State<UpdateBusinessScreen> {
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
        BlocProvider.of<UpdateBusinessBloc>(context).add(AddAvatar(avatar: file));
      } else {
        BlocProvider.of<UpdateBusinessBloc>(context).add(AddBackground(background: file));
      }
    }
  }

  final Debounce debounce = Debounce(duration: const Duration(milliseconds: 500));

  void onChange(String value, BuildContext context) {
    
    if (BlocProvider.of<UpdateBusinessBloc>(context).addressController.text.isNotEmpty) {
      debounce.call(() {
        BlocProvider.of<UpdateBusinessBloc>(context).add(OnSearchLocation(show: true));
      });
    } else {
      BlocProvider.of<UpdateBusinessBloc>(context).add(OnSearchLocation(show: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBusinessBloc(companyUseCase: instance.get<CompanyUseCase>())..add(GetProfile()),
      child: CommonScaffold(
          hideKeyboardWhenTouchOutside: true,
          isSafe: true,
          appBar: AppHeader(
            text: Text(
              'Update Business',
              style: themeData.textTheme.displayMedium,
            ),
          ),
          body: BlocBuilder<UpdateBusinessBloc, UpdateBusinessState>(
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
                                        imageUrl: state.companyEntity.background.isEmpty
                                            ? 'https://picsum.photos/200'
                                            : state.companyEntity.background,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () => _pickImage(context: context, isAvatar: false),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(Icons.camera_alt_rounded),
                                ),
                              ),
                            )
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
                            Stack(
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
                                          imageUrl: state.companyEntity.logo.isEmpty
                                              ? 'https://picsum.photos/200'
                                              : state.companyEntity.logo,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                                        ),
                                      );
                                    },
                                  )),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: InkWell(
                                    onTap: () => _pickImage(context: context, isAvatar: true),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Icon(Icons.camera_alt_rounded, size: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            8.horizontalSpace,
                            Text(
                              state.companyEntity.name,
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
                                controller: context.read<UpdateBusinessBloc>().overviewController,
                                label: 'Overview',
                                maxLines: 5,
                                placeholder: 'Type your bio',
                                textInputAction: TextInputAction.next,
                                contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                              ),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      TextFieldFrom(
                                        controller: context.read<UpdateBusinessBloc>().addressController,
                                        label: 'Address',
                                        placeholder: 'Type your address',
                                        textInputAction: TextInputAction.next,
                                        prefixIcon: const Icon(
                                          Icons.location_on_sharp,
                                          size: 24,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            context.read<UpdateBusinessBloc>().add(SearchLocation());
                                          },
                                          borderRadius: BorderRadius.circular(8.r),
                                          child: Padding(
                                            padding: EdgeInsets.all(16.w),
                                            child: SvgPicture.asset(
                                              AppConstants.more,
                                            ),
                                          ),
                                        ),
                                        onChange: (val) {
                                          onChange(val, context);
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        width: MediaQuery.of(context).size.width,
                                        height: 300,
                                        child: const BusinessLocation(),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                  Visibility(
                                    visible: state.listLocationShow,
                                    child: Positioned(
                                      top: 110,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        color: Colors.grey[100],
                                        child: ListView.builder(
                                          itemCount: state.location.length,
                                          itemBuilder: (context, index) {
                                            return _location(state.location[index], context);
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              PrimaryButton(
                                onPressed: () {
                                  context.read<UpdateBusinessBloc>().add(UpdateBusiness());
                                },
                                label: 'Edit',
                              ),
                              const SizedBox(height: 50,),
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

  Widget _location(String value, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            BlocProvider.of<UpdateBusinessBloc>(context).add(OnSelect(location: value));
          },
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.location_on),
              Expanded(
                child: Text(
                value,
                style: themeData.textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
                            ),
              ),
              const SizedBox(width: 45)
            ],
          ),
        ),
      ),
    );
  }
}
