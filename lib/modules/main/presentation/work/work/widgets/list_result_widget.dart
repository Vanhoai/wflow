import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class ListResultWidget extends StatefulWidget {
  const ListResultWidget({super.key});

  @override
  State<ListResultWidget> createState() => _ListResultWidgetState();
}

class _ListResultWidgetState extends State<ListResultWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 7, left: 20),
            sliver: SliverToBoxAdapter(
              child: Text(
                '18 result',
                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                  color: themeData.colorScheme.onBackground,
                )),
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
                    boxShadow: [
                      BoxShadow(
                        color: themeData.colorScheme.onBackground.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                      BoxShadow(
                        color: themeData.colorScheme.onBackground.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  header: Header(
                    title: Text(
                      'Tran Van Hoai',
                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
                    ),
                    onTapTitle: () {},
                    onTapLeading: () {},
                    subtitle: Text(
                      'hoai',
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
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
                  description: TextMore(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    trimMode: TrimMode.Hidden,
                    trimHiddenMaxLines: 2,
                    style: themeData.textTheme.displaySmall!.merge(TextStyle(
                      color: themeData.colorScheme.onBackground,
                    )),
                  ),
                  progress: const [
                    '1.5 years of experience in Flutter',
                  ],
                  showMore: true,
                  skillCallback: (value) {},
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
