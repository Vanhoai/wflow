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

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  final int _choiceValue = 0;
  late TextEditingController _searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return CommonScaffold(
      // ! REFRESH INDICATOR =>>>>>>>>>>>>>>>>>>>
      hideKeyboardWhenTouchOutside: true,
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
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://picsum.photos/200',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                      width: 48,
                      height: 48,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(child: Text('WFlow', style: themeData.textTheme.headlineSmall)),
                ],
              )),
            ),
            //! Header =>>>>>>>>>>>>>>>>>>>

            // ! Search Bar =>>>>>>>>>>>>>>>>>>>
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.0,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 5,
                              offset: const Offset(1, 1),
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                          controller: _searchController,
                          clipBehavior: Clip.none,
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            print('Lazy Search: $value');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        print('Search');
                      },
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.0,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 5,
                              offset: const Offset(1, 1),
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // ! Search Bar =>>>>>>>>>>>>>>>>>>>

            //! Vertical List Result =>>>>>>>>>>>>>>>>>>>
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '18 results',
                  style: themeData.textTheme.titleMedium,
                ),
              ),
            ),

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
            //! Vertical List Result =>>>>>>>>>>>>>>>>>>>
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
