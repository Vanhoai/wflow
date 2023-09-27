import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

final List<Map<String, dynamic>> staticMenuSelection = [
  {
    'title': 'Balance',
    'icon': Icons.account_balance_wallet,
    'onTap': () {},
  },
  {
    'title': 'Reputation',
    'icon': Icons.star,
    'onTap': () {},
  },
  {
    'title': 'Business',
    'icon': Icons.business,
    'onTap': () {},
  },
  {
    'title': 'More',
    'icon': Icons.more_horiz,
    'onTap': () {},
  }
];

final List<Map<String, dynamic>> staticRecentTitle = [
  {'title': 'All'},
  {'title': 'Part time'},
  {'title': 'Full time'},
  {'title': 'Remote'}
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _choiceValue = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return CommonScaffold(
      // ! REFRESH INDICATOR =>>>>>>>>>>>>>>>>>>>
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void>.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            //! Header =>>>>>>>>>>>>>>>>>>>
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: Header(
                  subtitle: const Text('vyhhps22919@fpt.edu.vn'),
                  title: const Text('Huynh Hong Vy'),
                  leadingPadding: const EdgeInsets.only(right: 8.0),
                  onTapLeading: () {},
                  onTapTitle: () {},
                  actionsSpacing: 4,
                  actions: [
                    IconButton.outlined(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                      tooltip: 'Search',
                    ),
                    IconButton.outlined(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                      tooltip: 'Notifications',
                    ),
                  ],
                ),
              ),
            ),
            //! Header =>>>>>>>>>>>>>>>>>>>

            //! Horizontal Menu Selection =>>>>>>>>>>>>>>>>>>>
            SliverPadding(
              padding: const EdgeInsets.only(top: 8),
              sliver: SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 90,
                    maxHeight: 100,
                  ),
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: staticMenuSelection.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: constraints.maxWidth / 4,
                            child: InkWell(
                              onTap: staticMenuSelection[index]['onTap'],
                              borderRadius: BorderRadius.circular(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: themeData.primaryColor.withOpacity(0.5),
                                          blurRadius: 0.0,
                                        ),
                                        BoxShadow(
                                          color: themeData.primaryColor.withOpacity(0.4),
                                          blurRadius: 10,
                                          offset: const Offset(1, 1),
                                          blurStyle: BlurStyle.solid,
                                        )
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      staticMenuSelection[index]['icon'],
                                      size: 32,
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                          color: themeData.primaryColor.withOpacity(0.5),
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    staticMenuSelection[index]['title'],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            //! Horizontal Menu Selection =>>>>>>>>>>>>>>>>>>>

            //! Horizontal List Hot Job =>>>>>>>>>>>>>>>>>>>
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Hot Job',
                  style: themeData.textTheme.titleMedium,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 360,
                  maxHeight: 380,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: constraints.maxWidth * 0.8,
                          height: constraints.maxHeight,
                          child: JobCard(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            boxDecoration: BoxDecoration(
                              color: themeData.colorScheme.background,
                              border: Border.all(
                                color: themeData.colorScheme.onBackground,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(4),
                            header: Header(
                              title: const Text('Tran Van Hoai'),
                              subtitle: const Text('hoai'),
                              leadingPadding: const EdgeInsets.only(right: 8.0),
                              actions: [
                                IconButton.filled(
                                  icon: Icon(Icons.bookmark_add, color: themeData.colorScheme.onBackground),
                                  onPressed: () {},
                                  padding: const EdgeInsets.all(0),
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Save',
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  ),
                                  highlightColor: Colors.blue.withOpacity(0.5),
                                ),
                              ],
                            ),
                            cost: '1000\$',
                            skill: const [
                              'Flutter',
                              'Dart',
                              'Firebase',
                              'NodeJS',
                              'ExpressJSExpressJSExpressJSExpressJS '
                            ],
                            duration: '1 month',
                            description: const TextMore(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              trimMode: TrimMode.Hidden,
                              trimHiddenMaxLines: 3,
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    );
                  },
                ),
              ),
            ),
            //! Horizontal List Hot Job =>>>>>>>>>>>>>>>>>>>

            //! Vertical List Recent Job =>>>>>>>>>>>>>>>>>>>
            SliverPadding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Recent Job',
                  style: themeData.textTheme.titleMedium,
                ),
              ),
            ),

            // ! Choice Filter Section =>>>>>>>>>>>>>>>>>>>
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 60,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 8.0),
                    itemBuilder: (context, index) {
                      final e = staticRecentTitle[index];
                      return ChoiceChip.elevated(
                        label: Text(e['title']),
                        selected: _choiceValue == staticRecentTitle.indexOf(e),
                        onSelected: (value) {
                          setState(() {
                            _choiceValue = staticRecentTitle.indexOf(e);
                          });
                        },
                        showCheckmark: false,
                      );
                    },
                    itemCount: staticRecentTitle.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
              ),
            ),
            // ! Choice Filter Section =>>>>>>>>>>>>>>>>>>>

            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  return JobCard(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    boxDecoration: BoxDecoration(
                      color: themeData.colorScheme.background,
                      border: Border.all(
                        color: themeData.colorScheme.onBackground,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(4),
                    header: Header(
                      title: const Text('Tran Van Hoai'),
                      subtitle: const Text('hoai'),
                      leadingPadding: const EdgeInsets.only(right: 8.0),
                      actions: [
                        IconButton.filled(
                          icon: Icon(Icons.bookmark_add, color: themeData.colorScheme.onBackground),
                          onPressed: () {},
                          padding: const EdgeInsets.all(0),
                          visualDensity: VisualDensity.compact,
                          tooltip: 'More',
                          color: Colors.transparent,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          highlightColor: Colors.blue.withOpacity(0.5),
                        ),
                      ],
                    ),
                    cost: '1000\$',
                    skill: const ['Flutter', 'Dart', 'Firebase', 'NodeJS', 'ExpressJS'],
                    duration: '1 month',
                    description: const TextMore(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      trimMode: TrimMode.Line,
                      trimLines: 3,
                    ),
                    showMore: true,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8.0);
                },
                itemCount: 10,
              ),
            ),
            //! Vertical List Recent Job =>>>>>>>>>>>>>>>>>>>
          ],
          clipBehavior: Clip.none,
          cacheExtent: 1000,
          dragStartBehavior: DragStartBehavior.start,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
