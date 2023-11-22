import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          6.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              children: widget.skills
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 40,
                        child: ChoiceChip.elevated(
                          label: Text('#$e', style: themeData.textTheme.displayMedium!.copyWith(color: Colors.black)),
                          selected: false,
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                          labelStyle: themeData.textTheme.displayLarge!.copyWith(color: Colors.black),
                          color: MaterialStatePropertyAll(themeData.colorScheme.background),
                          elevation: 2,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
