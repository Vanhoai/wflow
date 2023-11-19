import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/utils/string.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/widgets/related_job_widget.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/widgets/select_cv_widget.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/widgets/widget.dart';

import 'bloc/job_information_bloc/bloc.dart';
import 'bloc/job_information_bloc/event.dart';
import 'bloc/job_information_bloc/state.dart';

class JobInformationScreen extends StatefulWidget {
  const JobInformationScreen({super.key, required this.work});

  final num work;

  @override
  State<JobInformationScreen> createState() => _JobInformationScreenState();
}

class _JobInformationScreenState extends State<JobInformationScreen> {
  int choiceValue = 0;
  late ScrollController skillScrollController;
  late TextEditingController dialogInputController;
  late ScrollController relatedJobScrollController;

  late bool isUser;
  bool isYourBusiness = false;

  @override
  void initState() {
    super.initState();
    skillScrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
    relatedJobScrollController = ScrollController(initialScrollOffset: 0.0);
    dialogInputController = TextEditingController();
    isUser = instance.get<AppBloc>().state.role == 1;
  }

  @override
  void dispose() {
    skillScrollController.dispose();
    dialogInputController.dispose();
    super.dispose();
  }

  void callBackSetChoiceValue(int value) {
    setState(() {
      choiceValue = value;
    });
  }

  void navigateToCandidateList() {
    Navigator.of(context).pushNamed(RouteKeys.candidateListScreen);
  }

  _showSelectCV(BuildContext context, num idPost) async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectCVWidget(work: idPost);
      },
    );
    if (result != null && context.mounted) {
      var getIntroduction = await _displayTextInputDialog(context);
      if (getIntroduction != null && context.mounted) {
        BlocProvider.of<JobInformationBloc>(context)
            .add(ApplyPostEvent(post: widget.work, cv: (result as int), introduction: dialogInputController.text));
        dialogInputController.clear();
      }
    }
  }

  _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Theme(
              data: themeData.copyWith(dialogBackgroundColor: themeData.colorScheme.background),
              child: AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                backgroundColor: themeData.colorScheme.background,
                surfaceTintColor: Colors.transparent,
                insetPadding: EdgeInsets.all(12.r),
                title: const Text('Introduction'),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        style: Theme.of(context).textTheme.bodyLarge,
                        minLines: 3,
                        maxLines: 5,
                        controller: dialogInputController,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: 'Type your introduction',
                          contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black26),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: AppColors.primary, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: Colors.black26, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      PrimaryButton(label: 'Send', onPressed: () => Navigator.pop(context, true))
                    ],
                  ),
                ),
              ));
        });
  }

  Future<void> listener(BuildContext context, JobInformationState state) async {
    if (state is ApplyPostState) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Notification',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            content: Padding(
              padding: EdgeInsets.all(12.r),
              child: Text(state.message),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.primary),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (_) =>
          JobInformationBloc(postUseCase: instance.get<PostUseCase>(), contractUseCase: instance.get<ContractUseCase>())
            ..add(GetJobInformationEvent(id: widget.work.toString())),
      child: BlocConsumer<JobInformationBloc, JobInformationState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: listener,
        builder: (context, state) {
          var title = 'Information';
          if (state is GetJobInformationSuccessState) {
            title = state.postEntity.position;
            isYourBusiness = instance.get<AppBloc>().state.userEntity.business == state.postEntity.business;
          }
          return CommonScaffold(
            hideKeyboardWhenTouchOutside: true,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppConstants.backArrow,
                    height: 28,
                    width: 28,
                  ),
                ),
              ),
              actions: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (isYourBusiness) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Icon(
                                Icons.contact_page,
                                color: Theme.of(context).primaryColor,
                              )),
                          onTap: () {},
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
              backgroundColor: themeData.colorScheme.background,
              surfaceTintColor: Colors.transparent,
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: RefreshIndicator(
              onRefresh: () async =>
                  context.read<JobInformationBloc>().add(GetJobInformationEvent(id: widget.work.toString())),
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (state is GetJobInformationSuccessState) {
                        return Stack(
                          children: [
                            CustomScrollView(
                              slivers: [
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  sliver: SliverToBoxAdapter(
                                    child: Header(
                                      title: Text(
                                        instance.get<AppLocalization>().translate('business') ?? 'Company',
                                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                          color: themeData.colorScheme.onBackground,
                                        )),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        state.postEntity.creatorName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                          color: themeData.colorScheme.onBackground,
                                        )),
                                      ),
                                      onTapLeading: () {},
                                      leadingPhotoUrl: state.postEntity.companyLogo,
                                      leadingBadge: false,
                                      actions: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/checkgreen.svg',
                                              width: 20,
                                              height: 20,
                                            ),
                                            Text(
                                                instance
                                                    .get<ConvertString>()
                                                    .timeFormat(value: state.postEntity.updatedAt!),
                                                style: themeData.textTheme.displayMedium!
                                                    .merge(TextStyle(color: themeData.colorScheme.onBackground))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  sliver: SliverToBoxAdapter(
                                    child: CustomScrollView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      slivers: [
                                        WorkNameWidget(workName: state.postEntity.title),
                                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                                        DescWidget(description: state.postEntity.content),
                                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                                        BudgetWidget(budget: state.postEntity.salary),
                                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                                        TaskWidget(tasks: state.postEntity.tasks),
                                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                                      ],
                                      dragStartBehavior: DragStartBehavior.start,
                                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                                    ),
                                  ),
                                ),
                                RequireSkill(
                                  scrollController: skillScrollController,
                                  onSelected: callBackSetChoiceValue,
                                  skills: state.postEntity.skills,
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.all(20),
                                  sliver: SliverToBoxAdapter(
                                    child: Header(
                                      title: Text(
                                        '${instance.get<AppLocalization>().translate("creator")} 😎',
                                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                          color: themeData.colorScheme.onBackground,
                                        )),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        state.postEntity.creatorName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                          color: themeData.colorScheme.onBackground,
                                        )),
                                      ),
                                      leadingPhotoUrl: state.postEntity.creatorAvatar,
                                      onTapLeading: () {},
                                      leadingBadge: false,
                                    ),
                                  ),
                                ),
                                SliverToBoxAdapter(child: 6.verticalSpace),
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  sliver: SliverToBoxAdapter(
                                    child: Text(
                                      '🔧 Related Jobs',
                                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground,
                                        fontSize: 18,
                                      )),
                                    ),
                                  ),
                                ),
                                SliverToBoxAdapter(child: 6.verticalSpace),
                                RelatedJobWidget(
                                  scrollController: relatedJobScrollController,
                                  currentJobId: widget.work,
                                ),
                                const SliverToBoxAdapter(child: SizedBox(height: 100)),
                              ],
                              dragStartBehavior: DragStartBehavior.start,
                              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  if (isUser) {
                                    return Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(20),
                                      child: PrimaryButton(
                                        label: instance.get<AppLocalization>().translate('apply') ?? 'Apply',
                                        onPressed: () {
                                          if (instance.get<AppBloc>().state.userEntity.isVerify) {
                                            _showSelectCV(context, widget.work);
                                          } else {
                                            Navigator.of(context).pushNamed(RouteKeys.auStepOneScreen);
                                          }
                                        },
                                      ),
                                    );
                                  } else if (isYourBusiness) {
                                    return Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(20),
                                      child: PrimaryButton(
                                        label: instance.get<AppLocalization>().translate('viewCandidate') ??
                                            'View Candidate',
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            RouteKeys.candidateListScreen,
                                            arguments: widget.work,
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            )
                          ],
                        );
                      } else if (state is GetJobInformationFailureState) {
                        return Center(
                          child: Text('No Information', style: Theme.of(context).textTheme.bodyLarge),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  Positioned(
                    child: Visibility(
                      visible: state.isLoading,
                      child: const LoadingWithWhite(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
