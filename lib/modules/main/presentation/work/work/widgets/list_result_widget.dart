import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class ListResultWidget extends StatefulWidget {
  const ListResultWidget({super.key});

  @override
  State<ListResultWidget> createState() => _ListResultWidgetState();
}

class _ListResultWidgetState extends State<ListResultWidget> {
  List<String> categories = [
    'All',
    'Part time',
    'Full time',
    'Remote',
    'Internship',
    'Freelance',
    'Flutter',
    'Dart',
    'Firebase'
  ];
  String selectedCategory = 'All';

  void _onSelected(String value) {
    setState(() {
      selectedCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Categories',
              style: themeData.textTheme.displayMedium,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, top: 8),
            height: 40,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = category == selectedCategory;

                return SizedBox(
                  height: 32,
                  child: ChoiceChip.elevated(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    label: Text(category),
                    selected: selected,
                    onSelected: (value) => _onSelected(category),
                    showCheckmark: false,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    visualDensity: VisualDensity.compact,
                    labelStyle: themeData.textTheme.labelMedium!.copyWith(
                      color: selected ? Colors.white : themeData.colorScheme.onBackground,
                    ),
                    color: selected
                        ? const MaterialStatePropertyAll(AppColors.primary)
                        : MaterialStatePropertyAll(themeData.colorScheme.background),
                    elevation: 2,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20, top: 2),
                itemBuilder: (context, index) {
                  return JobCard(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        'Flutter Developer',
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground,
                        )),
                      ),
                      onTapTitle: () {},
                      onTapLeading: () {},
                      subtitle: Text(
                        'Google',
                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground,
                        )),
                      ),
                      leadingSize: 30,
                      actions: [
                        InkWell(
                          child: SvgPicture.asset(
                            AppConstants.bookmark,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              themeData.colorScheme.onBackground.withOpacity(0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
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
                    progress: const ['1.5 years of experience in Flutter'],
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
          ),
        ],
      ),
    );
  }
}
