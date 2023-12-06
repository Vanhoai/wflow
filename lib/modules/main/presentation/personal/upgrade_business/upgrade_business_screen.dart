import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/domain/media/media_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/dialog_pick_image.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/input_group.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/pick_image_card.dart';

class UpgradeBusinessScreen extends StatefulWidget {
  const UpgradeBusinessScreen({super.key});

  @override
  State<UpgradeBusinessScreen> createState() => _UpgradeBusinessScreenState();
}

class _UpgradeBusinessScreenState extends State<UpgradeBusinessScreen> {
  File? _image;
  bool _isImage = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController overviewController = TextEditingController();

  void _pickImageFromGallery() => Navigator.pop(context, ImageSource.gallery);
  void _pickImageFromCamera() => Navigator.pop(context, ImageSource.camera);

  Future<void> _pickImage({required BuildContext context}) async {
    ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => DialogPickImage(
        pickImageFromCamera: () => _pickImageFromCamera(),
        pickImageFromGallery: () => _pickImageFromGallery(),
      ),
    );

    if (source != null) {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);

      setState(() {
        _image = imageTemporary;
        _isImage = !_isImage;
      });
    } else {
      return;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    overviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (_) => UpgradeBusinessBloc(
        companyUseCase: instance.get<CompanyUseCase>(),
        mediaUseCase: instance.get<MediaUseCase>(),
      ),
      child: Scaffold(
        appBar: AppHeader(
          text: Text(
            instance.get<AppLocalization>().translate('upgradeBusiness') ?? 'Upgrade Business',
            style: themeData.textTheme.displayMedium,
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppSize.paddingScreenDefault,
                    right: AppSize.paddingScreenDefault,
                  ),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          instance.get<AppLocalization>().translate('logoForBusiness') ?? 'Logo for business',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      8.verticalSpace,
                      PickImageCard(
                        image: _image,
                        isImage: _isImage,
                        pickImage: () => _pickImage(context: context),
                      ),
                      const SizedBox(height: 28),
                      Column(
                        children: [
                          InputGroup(
                            editingController: nameController,
                            minLines: 1,
                            maxLines: 1,
                            labelText:
                                instance.get<AppLocalization>().translate('nameForBusiness') ?? 'Name for business',
                            hintText: instance.get<AppLocalization>().translate('enterNameForBusiness') ??
                                'Enter your name of business',
                          ),
                          24.verticalSpace,
                          InputGroup(
                            editingController: emailController,
                            minLines: 1,
                            maxLines: 1,
                            labelText:
                                instance.get<AppLocalization>().translate('emailForBusiness') ?? 'Email for business',
                            hintText: instance.get<AppLocalization>().translate('enterEmailForBusiness') ??
                                'Enter your email of business',
                          ),
                          24.verticalSpace,
                          InputGroup(
                            editingController: phoneController,
                            minLines: 1,
                            maxLines: 1,
                            labelText:
                                instance.get<AppLocalization>().translate('phoneForBusiness') ?? 'Phone for business',
                            hintText: instance.get<AppLocalization>().translate('enterPhoneForBusiness') ??
                                'Enter your phone of business',
                          ),
                          24.verticalSpace,
                          InputGroup(
                            editingController: overviewController,
                            minLines: 2,
                            maxLines: 4,
                            labelText: instance.get<AppLocalization>().translate('overviewForBusiness') ??
                                'Overview for business',
                            hintText: instance.get<AppLocalization>().translate('enterOverviewForBusiness') ??
                                'Enter your overview of business',
                          ),
                          24.verticalSpace,
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            instance.get<AppLocalization>().translate('fee') ?? 'Fee',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            '100.000 VND',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: BlocBuilder<UpgradeBusinessBloc, UpgradeBusinessState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          onPressed: () {
                            context.read<UpgradeBusinessBloc>().add(
                                  UpgradeBusinessSubmitEvent(
                                    logo: _image!,
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    overview: overviewController.text,
                                  ),
                                );
                          },
                          label: instance.get<AppLocalization>().translate('upgrade') ?? 'Upgrade',
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
