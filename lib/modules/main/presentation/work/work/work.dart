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

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      isSafe: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void>.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
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
                    Expanded(
                        child: Text('WFlow',
                            style: themeData.textTheme.titleLarge!
                                .merge(const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(10.0),
                            filled: true,
                            fillColor: Colors.white,
                            disabledBorder: InputBorder.none,
                          ),
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
                    Material(
                      color: themeData.colorScheme.background,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(12.0),
                      child: InkWell(
                        onTap: () {
                          print('Search');
                        },
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.transparent,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                AppConstants.ic_filter,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 7, left: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '18 result',
                  style: themeData.textTheme.titleMedium!.merge(
                    const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                    skillCallback: (value) {
                      print('Skill: $value');
                    },
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
