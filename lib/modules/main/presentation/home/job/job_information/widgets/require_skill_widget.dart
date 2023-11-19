import 'package:flutter/material.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';

class RequireSkill extends StatefulWidget {
  final List<String> skills;
  const RequireSkill({required this.skills, super.key, required this.scrollController, required this.onSelected});

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
              '📌 ${instance.get<AppLocalization>().translate("requireSkills")}',
              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
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
              itemCount: widget.skills.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              itemBuilder: (context, index) {
                final e = widget.skills[index];
                return SizedBox(
                  height: 40,
                  child: ChoiceChip.elevated(
                    label: Text('# $e', style: themeData.textTheme.displayMedium),
                    selected: false,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    visualDensity: VisualDensity.compact,
                    labelStyle: themeData.textTheme.displayLarge!.copyWith(
                      color: Colors.black,
                    ),
                    color: MaterialStatePropertyAll(themeData.colorScheme.background),
                    elevation: 3,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
