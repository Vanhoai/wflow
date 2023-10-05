import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/home/post/job_information/widgets/widget.dart';

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
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, false),
              ),
              backgroundColor: themeData.colorScheme.background,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              snap: false,
              floating: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
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
            const SliverToBoxAdapter(child: SizedBox(height: 50)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              sliver: SliverToBoxAdapter(
                child: PrimaryButton(
                  label: 'View Candidate',
                  onPressed: () {},
                  width: double.infinity,
                ),
              ),
            ),
          ],
          clipBehavior: Clip.none,
          cacheExtent: 1000,
          dragStartBehavior: DragStartBehavior.start,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
