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
  int _choiceValue = 0;

  late ScrollController _scrollController;
  late void Function(int) onSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = widget.scrollController;
    onSelected = widget.onSelected;
  }

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
          const SizedBox(height: 13.0),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 42,
            ),
            child: ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final e = staticRequireSkill[index];
                return SizedBox(
                  height: 28,
                  child: ChoiceChip.elevated(
                    label: Text(e['title']),
                    selected: _choiceValue == staticRequireSkill.indexOf(e),
                    onSelected: (value) {
                      setState(() {
                        _choiceValue = staticRequireSkill.indexOf(e);
                        onSelected(_choiceValue);
                      });
                    },
                    showCheckmark: false,
                    labelPadding: EdgeInsets.zero,
                    // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                    visualDensity: VisualDensity.compact,
                    labelStyle: themeData.textTheme.displayLarge!.copyWith(
                      color: _choiceValue == staticRequireSkill.indexOf(e)
                          ? Colors.white
                          : themeData.colorScheme.onBackground,
                    ),
                    color: _choiceValue == staticRequireSkill.indexOf(e)
                        ? const MaterialStatePropertyAll(Colors.blue)
                        : MaterialStatePropertyAll(themeData.colorScheme.background),
                    elevation: 2,
                  ),
                );
              },
              itemCount: staticRequireSkill.length,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
