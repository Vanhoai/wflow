import 'package:flutter/material.dart';

final List<Map<String, dynamic>> staticRequireSkill = [
  {'title': 'Database'},
  {'title': 'Design'},
  {'title': 'Mobile'},
  {'title': 'Web'},
  {'title': 'Iot'},
  {'title': 'Sale'}
];

class RequireSkill extends StatefulWidget {
  const RequireSkill({super.key, required this.scrollController, required this.onSelected});

  final ScrollController scrollController;
  final Function(int) onSelected;

  @override
  State<RequireSkill> createState() => _RequireSkillState();
}

class _RequireSkillState extends State<RequireSkill> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '# Require skills',
              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                fontSize: 18,
              )),
            ),
          ),
          const SizedBox(height: 12.0),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 50,
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final e = staticRequireSkill[index];
                return SizedBox(
                  height: 28,
                  child: ChoiceChip.elevated(
                    label: Text(e['title'], style: themeData.textTheme.displayMedium),
                    selected: false,
                    showCheckmark: false,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    visualDensity: VisualDensity.compact,
                    labelStyle: themeData.textTheme.displayLarge!.copyWith(
                      color: themeData.colorScheme.onBackground,
                    ),
                    color: MaterialStatePropertyAll(themeData.colorScheme.background),
                    elevation: 3,
                  ),
                );
              },
              itemCount: staticRequireSkill.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
