import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/state.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/widgets/widget.dart';

import 'bloc/bloc.dart';
import 'bloc/event.dart';

class JobInformationScreen extends StatefulWidget {
  const JobInformationScreen({super.key, required this.work});

  final num work;

  @override
  State<JobInformationScreen> createState() => _JobInformationScreenState();
}

class _JobInformationScreenState extends State<JobInformationScreen> {
  int choiceValue = 0;
  late ScrollController _skillScrollController;

  @override
  void initState() {
    super.initState();
    _skillScrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
  }

  void callBackSetChoiceValue(int value) {
    setState(() {
      choiceValue = value;
    });
  }

  void navigateToCandidateList() {
    Navigator.of(context).pushNamed(RouteKeys.candidateListScreen);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: BlocProvider(
        create: (_) =>
            JobInformationBloc(postUseCase: instance.get<PostUseCase>())
              ..add(GetJobInformationEvent(id: widget.work.toString())),
        child: RefreshIndicator(onRefresh: () async {
          context
              .read<JobInformationBloc>()
              .add(GetJobInformationEvent(id: widget.work.toString()));
        }, child: BlocBuilder<JobInformationBloc, JobInformationState>(
            builder: (context, state) {
          return Visibility(
              visible: !state.isLoading,
              replacement: Shimmer.fromColors(
                  baseColor:
                      themeData.colorScheme.onBackground.withOpacity(0.1),
                  highlightColor:
                      themeData.colorScheme.onBackground.withOpacity(0.05),
                  child: Container()),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (state is GetJobInformationSuccessState) {
                    return Stack(
                      children: [
                        CustomScrollView(
                          slivers: [
                            SliverAppBar(
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
                              backgroundColor: themeData.colorScheme.background,
                              surfaceTintColor: Colors.transparent,
                              pinned: true,
                              title: const Text(
                                'Information',
                                textAlign: TextAlign.center,
                              ),
                              centerTitle: true,
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              sliver: SliverToBoxAdapter(
                                child: Header(
                                  title: Text(
                                    state.postEntity.companyName,
                                    style: themeData.textTheme.displayLarge!
                                        .merge(TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    )),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    state.postEntity.creatorName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: themeData.textTheme.displayLarge!
                                        .merge(TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    )),
                                  ),
                                  onTapLeading: () {},
                                  onTapTitle: () {},
                                  leadingPhotoUrl: state.postEntity.companyLogo,
                                  leadingBadge: false,
                                  actions: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/checkgreen.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        Text('2 minutes ago',
                                            style: themeData
                                                .textTheme.displayMedium!
                                                .merge(TextStyle(
                                                    color: themeData.colorScheme
                                                        .onBackground))),
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
                                    const SliverToBoxAdapter(
                                        child: SizedBox(height: 40)),
                                    DescWidget(description: state.postEntity.content),
                                    const SliverToBoxAdapter(
                                        child: SizedBox(height: 40)),
                                    BudgetWidget(budget: state.postEntity.salary),
                                    const SliverToBoxAdapter(
                                        child: SizedBox(height: 40)),
                                    TaskWidget(tasks: state.postEntity.tasks),
                                    const SliverToBoxAdapter(
                                        child: SizedBox(height: 40)),
                                  ],
                                  clipBehavior: Clip.none,
                                  cacheExtent: 1000,
                                  dragStartBehavior: DragStartBehavior.start,
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.manual,
                                ),
                              ),
                            ),
                            RequireSkill(
                              scrollController: _skillScrollController,
                              onSelected: callBackSetChoiceValue,
                              skills: state.postEntity.skills,
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 20),
                              sliver: SliverToBoxAdapter(
                                child: Header(
                                  title: Text(
                                    'Creator 😎',
                                    style: themeData.textTheme.displayMedium!
                                        .merge(TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    )),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    state.postEntity.creatorName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: themeData.textTheme.displayMedium!
                                        .merge(TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    )),
                                  ),
                                  leadingPhotoUrl: state.postEntity.creatorAvatar,
                                  onTapLeading: () {},
                                  onTapTitle: () {},
                                  leadingBadge: false,
                                ),
                              ),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 60)),
                          ],
                          clipBehavior: Clip.none,
                          cacheExtent: 1000,
                          dragStartBehavior: DragStartBehavior.start,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.manual,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(20),
                            child: PrimaryButton(
                              label: 'View Candidate',
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (state is GetJobInformationFailureState) {
                    return Center(
                      child: Text("Không tìm thấy nội dung",
                          style: Theme.of(context).textTheme.bodyLarge),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ));
        })),
      ),
    );
  }
}
