import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/widgets/widget.dart';

class JobInformationScreen extends StatefulWidget {
  const JobInformationScreen({super.key});

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
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 1));
        },
        child: Stack(
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
                        'Trần Văn Hoài',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground,
                        )),
                      ),
                      onTapLeading: () {},
                      onTapTitle: () {},
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
                            Text('2 minutes ago',
                                style: themeData.textTheme.displayMedium!
                                    .merge(TextStyle(color: themeData.colorScheme.onBackground))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: CustomScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        WorkNameWidget(),
                        SliverToBoxAdapter(child: SizedBox(height: 40)),
                        DescWidget(),
                        SliverToBoxAdapter(child: SizedBox(height: 40)),
                        BudgetWidget(),
                        SliverToBoxAdapter(child: SizedBox(height: 40)),
                        TaskWidget(),
                        SliverToBoxAdapter(child: SizedBox(height: 40)),
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
                        'Trần Văn Hoài',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground,
                        )),
                      ),
                      onTapLeading: () {},
                      onTapTitle: () {},
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
        ),
      ),
    );
  }
}
