import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
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
  late ScrollController _skillScrollController;
  late bool isUser;
  bool isYourBusiness = false;

  @override
  void initState() {
    super.initState();
    _skillScrollController = ScrollController(
      initialScrollOffset: 0.0,
    );

    isUser = instance.get<AppBloc>().state.role == 1;
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
      BlocProvider.of<JobInformationBloc>(context).add(ApplyPostEvent(post: widget.work, cv: (result as int)));
    }
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                        // final date = DateTime.fromMillisecondsSinceEpoch((int.parse(state.postEntity.updatedAt)));
                        return Stack(
                          children: [
                            CustomScrollView(
                              slivers: [
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                                  sliver: SliverToBoxAdapter(
                                    child: Header(
                                      title: Text(
                                        'Company',
                                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                          color: themeData.colorScheme.onBackground,
                                        )),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        state.postEntity.companyName,
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
                                            Text(Time().getDayMonthYear(state.postEntity.createdAt.toString()),
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
                                        const SliverToBoxAdapter(child: SizedBox(height: 40)),
                                        DescWidget(description: state.postEntity.content),
                                        const SliverToBoxAdapter(child: SizedBox(height: 40)),
                                        BudgetWidget(budget: state.postEntity.salary),
                                        const SliverToBoxAdapter(child: SizedBox(height: 40)),
                                        TaskWidget(tasks: state.postEntity.tasks),
                                        const SliverToBoxAdapter(child: SizedBox(height: 40)),
                                      ],
                                      clipBehavior: Clip.none,
                                      cacheExtent: 1000,
                                      dragStartBehavior: DragStartBehavior.start,
                                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                                    ),
                                  ),
                                ),
                                RequireSkill(
                                  scrollController: _skillScrollController,
                                  onSelected: callBackSetChoiceValue,
                                  skills: state.postEntity.skills,
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                                  sliver: SliverToBoxAdapter(
                                    child: Header(
                                      title: Text(
                                        'Creator 😎',
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
                                const SliverToBoxAdapter(child: SizedBox(height: 60)),
                              ],
                              clipBehavior: Clip.none,
                              cacheExtent: 1000,
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
                                        label: 'Apply',
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
                                        label: 'View Candidate',
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white.withOpacity(0.1),
                        child: const Loading(),
                      ),
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
