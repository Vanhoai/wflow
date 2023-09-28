import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

final List<Map<String, dynamic>> staticMenuSelection = [
  {
    'title': 'Balance',
    'icon': AppConstants.ic_balance,
    'onTap': () {},
  },
  {
    'title': 'Reputation',
    'icon': AppConstants.ic_reputation,
    'onTap': () {},
  },
  {
    'title': 'Business',
    'icon': AppConstants.ic_business,
    'onTap': () {},
  },
  {
    'title': 'More',
    'icon': AppConstants.ic_more,
    'onTap': () {},
  }
];

final List<Map<String, dynamic>> staticRecentTitle = [
  {'title': 'All'},
  {'title': 'Part time'},
  {'title': 'Full time'},
  {'title': 'Remote'},
  {'title': 'Remote'},
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
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return CommonScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void>.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Header(
                  subtitle: const Text(
                    'vyhhps22919@fpt.edu.vn',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  title: const Text(
                    'Huynh Hong Vy',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTapLeading: () {},
                  onTapTitle: () {},
                  leadingBadge: true,
                  actions: [
                    InkWell(
                      onTap: () {},
                      radius: 99,
                      borderRadius: BorderRadius.circular(99),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(
                            color: themeData.colorScheme.onBackground.withOpacity(0.5),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        width: 28,
                        height: 28,
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(
                          AppConstants.ic_search,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {},
                      radius: 99,
                      borderRadius: BorderRadius.circular(99),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(
                                color: themeData.colorScheme.onBackground.withOpacity(0.5),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            width: 28,
                            height: 28,
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                              AppConstants.ic_notification,
                              width: 16,
                              height: 16,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20),
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
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      staticMenuSelection[index]['icon'],
                                      height: 24,
                                      width: 24,
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
            SliverPadding(
              padding: const EdgeInsets.only(top: 10, bottom: 2, left: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Hot Job',
                  style: themeData.textTheme.titleMedium!.merge(
                    const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(width: 16.0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 20.0),
                      itemBuilder: (context, index) {
                        return Container(
                          width: constraints.maxWidth * 0.8,
                          height: constraints.maxHeight,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: JobCard(
                            boxDecoration: BoxDecoration(
                              color: themeData.colorScheme.background,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            header: Header(
                              title: const Text(
                                'Tran Van Hoai',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: const Text(
                                'hoai',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leadingSize: 30,
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
                            skill: const [
                              'Flutter',
                              'Dart',
                              'Firebase',
                            ],
                            cost: '1000\$',
                            duration: '1 month',
                            description: const TextMore(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              trimMode: TrimMode.Hidden,
                              trimHiddenMaxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
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
            SliverPadding(
              padding: const EdgeInsets.only(top: 7, bottom: 2, left: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Recent Job',
                  style: themeData.textTheme.titleMedium!.merge(
                    const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 42,
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(width: 8.0),
                  itemBuilder: (context, index) {
                    final e = staticRecentTitle[index];
                    return SizedBox(
                      height: 28,
                      child: ChoiceChip.elevated(
                        label: Text(e['title']),
                        selected: _choiceValue == staticRecentTitle.indexOf(e),
                        onSelected: (value) {
                          setState(() {
                            _choiceValue = staticRecentTitle.indexOf(e);
                          });
                        },
                        showCheckmark: false,
                        labelPadding: EdgeInsets.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                        visualDensity: VisualDensity.compact,
                        labelStyle: themeData.textTheme.titleMedium!.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: _choiceValue == staticRecentTitle.indexOf(e)
                              ? Colors.white
                              : themeData.colorScheme.onBackground,
                        ),
                        color: _choiceValue == staticRecentTitle.indexOf(e)
                            ? MaterialStatePropertyAll(Colors.blue.withOpacity(0.5))
                            : MaterialStatePropertyAll(themeData.colorScheme.background),
                        elevation: 2,
                      ),
                    );
                  },
                  itemCount: staticRecentTitle.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 20.0),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  return JobCard(
                    boxDecoration: BoxDecoration(
                      color: themeData.colorScheme.background,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    header: Header(
                      title: const Text(
                        'Tran Van Hoai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text(
                        'hoai',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leadingSize: 30,
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
                    skill: const [
                      'Flutter',
                      'Dart',
                      'Firebase',
                      'Dart',
                      'Firebase',
                      'Dart',
                      'Firebase',
                    ],
                    labelSkill: true,
                    cost: '1000\$',
                    duration: '1 month',
                    description: const TextMore(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      trimMode: TrimMode.Hidden,
                      trimHiddenMaxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                    progress: const [
                      '1.5 years of experience in Flutter',
                    ],
                    showMore: true,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16.0);
                },
                itemCount: 10,
              ),
            ),
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
