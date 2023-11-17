import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/bloc/bloc.dart';
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
  late TextEditingController budgetController;
  late TextEditingController duration;
  late TextEditingController position;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    budgetController = TextEditingController();
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
            'Up Post',
            style: themeData.textTheme.displayMedium,
          ),
        ),
        hideKeyboardWhenTouchOutside: false,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                                'Title',
                                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                )),
                              ),
                              8.verticalSpace,
                              TextFieldHelper(
                                controller: titleController,
                                maxLines: 2,
                                minLines: 1,
                                hintText: 'Enter project title',
                              ),
                              20.verticalSpace,
                              Text(
                                'Describe',
                                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                )),
                              ),
                              8.verticalSpace,
                              TextFieldHelper(
                                controller: descriptionController,
                                maxLines: 5,
                                minLines: 3,
                                hintText: 'Enter basic description',
                              ),
                              20.verticalSpace,
                              Text(
                                'Duration',
                                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                )),
                              ),
                              8.verticalSpace,
                              TextFieldHelper(
                                controller: duration,
                                maxLines: 1,
                                minLines: 1,
                                hintText: 'Enter duration (optional)',
                              ),
                              20.verticalSpace,
                              Text(
                                'Position',
                                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                )),
                              ),
                              8.verticalSpace,
                              TextFieldHelper(
                                controller: position,
                                maxLines: 1,
                                minLines: 1,
                                hintText: 'Enter position',
                              ),
                              20.verticalSpace,
                              Text(
                                'Budget',
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
                                hintText: 'Enter budget',
                                keyboardType: TextInputType.number,
                                suffixIcon: const Icon(Icons.attach_money_sharp),
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
                              ActionHelper(onUpload: () {}, onWatchVideo: () {}),
                              80.verticalSpace,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<UpPostBloc, UpPostState>(
                builder: (context, state) {
                  return Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.background,
                        ),
                        child: PrimaryButton(
                          label: 'Post',
                          onPressed: () {
                            context.read<UpPostBloc>().add(
                                  UpPostSubmitEvent(
                                    budget: budgetController.text,
                                    description: descriptionController.text,
                                    title: titleController.text,
                                    duration: duration.text,
                                    position: position.text,
                                  ),
                                );
                          },
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
