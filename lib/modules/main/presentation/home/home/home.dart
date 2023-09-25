import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

final List<Map<String, dynamic>> itemMenu = [
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            //! Header
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: Header(
                  title: 'Tran Van Hoai',
                  subtitle: 'tranvanhoai@gmail.com',
                  leadingPadding: const EdgeInsets.only(right: 8.0),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                      padding: const EdgeInsets.all(0),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Search',
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                      padding: const EdgeInsets.all(0),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Notifications',
                    ),
                  ],
                ),
              ),
            ),

            //! Horizontal Menu
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
                        itemCount: itemMenu.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: constraints.maxWidth / 4,
                            child: InkWell(
                              onTap: itemMenu[index]['onTap'],
                              borderRadius: BorderRadius.circular(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    itemMenu[index]['icon'],
                                    size: 32,
                                    color: themeData.primaryColor,
                                    shadows: [
                                      BoxShadow(
                                        color: themeData.primaryColor.withOpacity(0.5),
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    itemMenu[index]['title'],
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

            //! Horizontal List
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
                  minHeight: 350,
                  maxHeight: 400,
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
                              title: 'Tran Van Hoai',
                              subtitle: 'tranvanhoai@gmail.com',
                              leadingPadding: const EdgeInsets.only(right: 8.0),
                              actions: [
                                IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {},
                                  padding: const EdgeInsets.all(0),
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'More',
                                ),
                              ],
                            ),
                            costContent: '1000\$',
                            descriptionContent:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                            listSkill: const ['Flutter', 'Dart', 'Firebase', 'NodeJS', 'ExpressJS'],
                          ),
                        );
                      },
                      itemCount: 10,
                    );
                  },
                ),
              ),
            ),

            //! Vertical List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Recent Job',
                  style: themeData.textTheme.titleMedium,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 70,
                  maxHeight: 100,
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return const ChipCustom(
                      title: 'Part-time',
                    );
                  },
                  itemCount: 2,
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverToBoxAdapter(
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
                    title: 'Tran Van Hoai',
                    subtitle: 'tranvanhoai@gmail.com',
                    leadingPadding: const EdgeInsets.only(right: 8.0),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        visualDensity: VisualDensity.compact,
                        tooltip: 'More',
                      ),
                    ],
                  ),
                  costContent: '1000\$',
                  progressContent: const [
                    '1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '2. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '3. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '4. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '5. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '6. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ],
                  descriptionContent:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                  listSkill: const ['Flutter', 'Dart', 'Firebase', 'NodeJS', 'ExpressJS'],
                  showMore: true,
                ),
              ),
            )
          ],
          clipBehavior: Clip.none,
          cacheExtent: 1000,
          dragStartBehavior: DragStartBehavior.start,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
