import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/shimmer_up_post.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/skill_category.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/task_create_post.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class UpPostScreen extends StatefulWidget {
  const UpPostScreen({super.key});

  @override
  State<UpPostScreen> createState() => _UpPostScreenState();
}

class _UpPostScreenState extends State<UpPostScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late MoneyMaskedTextController budgetController;
  late TextEditingController duration;
  late TextEditingController position;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    budgetController =
        MoneyMaskedTextController(decimalSeparator: '', precision: 0, initialValue: 0, thousandSeparator: '.');
    duration = TextEditingController();
    position = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    duration.dispose();
    super.dispose();
  }

  Future<void> choseExcelFile(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xls', 'xlsx', 'xlsm']);
    if (result != null) {
      File file = File(result.files.single.path!);
      if (context.mounted) context.read<UpPostBloc>().add(AddTaskWithExcel(file: file));
    } else {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => UpPostBloc(
        categoryUseCase: instance.get<CategoryUseCase>(),
        contractUseCase: instance.get<ContractUseCase>(),
        postUseCase: instance.get<PostUseCase>(),
      )..add(UpPostInitialEvent()),
      child: CommonScaffold(
        appBar: AppHeader(
          text: Text(
            instance.get<AppLocalization>().translate('upPost') ?? 'Up Post',
            style: themeData.textTheme.displayLarge,
          ),
        ),
        hideKeyboardWhenTouchOutside: false,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<UpPostBloc, UpPostState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      label: instance.get<AppLocalization>().translate('up') ?? 'Up',
                      onPressed: () {
                        context.read<UpPostBloc>().add(
                              UpPostSubmitEvent(
                                budget: budgetController.numberValue.toInt().toString(),
                                description: descriptionController.text,
                                title: titleController.text,
                                duration: duration.text,
                                position: position.text,
                              ),
                            );
                      },
                      width: double.infinity,
                    );
                  },
                ),
              )
            ],
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<UpPostBloc, UpPostState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return Visibility(
                visible: !state.isLoading,
                replacement: const ShimmerUpPost(),
                child: Stack(
                  children: [
                    CustomScrollView(
                      clipBehavior: Clip.none,
                      cacheExtent: 1000,
                      dragStartBehavior: DragStartBehavior.start,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      instance.get<AppLocalization>().translate('title') ?? 'Title',
                                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                        color: themeData.colorScheme.onBackground,
                                      )),
                                    ),
                                    8.verticalSpace,
                                    TextFieldHelper(
                                      controller: titleController,
                                      maxLines: 2,
                                      minLines: 1,
                                      hintText: instance.get<AppLocalization>().translate('enterProjectTitle') ??
                                          'Enter title',
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      instance.get<AppLocalization>().translate('description') ?? 'Description',
                                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                        color: themeData.colorScheme.onBackground,
                                      )),
                                    ),
                                    8.verticalSpace,
                                    TextFieldHelper(
                                      controller: descriptionController,
                                      maxLines: 5,
                                      minLines: 3,
                                      hintText: instance.get<AppLocalization>().translate('enterProjectDescribe') ??
                                          'Enter basic description',
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      instance.get<AppLocalization>().translate('duration')!,
                                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                        color: themeData.colorScheme.onBackground,
                                      )),
                                    ),
                                    8.verticalSpace,
                                    TextFieldHelper(
                                      controller: duration,
                                      maxLines: 1,
                                      minLines: 1,
                                      hintText: instance.get<AppLocalization>().translate('enterDuration') ??
                                          'Enter duration (optional)',
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      instance.get<AppLocalization>().translate('position') ?? 'Position',
                                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                        color: themeData.colorScheme.onBackground,
                                      )),
                                    ),
                                    8.verticalSpace,
                                    TextFieldHelper(
                                      controller: position,
                                      maxLines: 1,
                                      minLines: 1,
                                      hintText: instance.get<AppLocalization>().translate('enterPosition') ??
                                          'Enter position',
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      instance.get<AppLocalization>().translate('budget') ?? 'Budget',
                                      style: themeData.textTheme.displayMedium!.merge(
                                        TextStyle(
                                          color: themeData.colorScheme.onBackground,
                                        ),
                                      ),
                                    ),
                                    8.verticalSpace,
                                    TextFieldHelper(
                                      controller: budgetController,
                                      maxLines: 1,
                                      minLines: 1,
                                      hintText:
                                          instance.get<AppLocalization>().translate('enterBudget') ?? 'Enter budget',
                                      keyboardType: TextInputType.number,
                                    ),
                                    20.verticalSpace,
                                  ],
                                ),
                              ),
                              20.verticalSpace,
                              const SkillAndCategory(),
                              20.verticalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const TaskCreatePost(),
                                    20.verticalSpace,
                                    ActionHelper(onUpload: () {
                                      choseExcelFile(context);
                                    }, onWatchVideo: () {
                                      Navigator.of(context).pushNamed(RouteKeys.guileUseExcelScreen);
                                    }),
                                    80.verticalSpace,
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
