import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';

final List<Map<String, dynamic>> staticRecentTitle = [
  {'title': 'All'},
  {'title': 'Part time'},
  {'title': 'Full time'},
  {'title': 'Remote'},
  {'title': 'Remote'},
  {'title': 'Remote'}
];

class SelectionListWidget extends StatefulWidget {
  const SelectionListWidget({super.key, required this.scrollController, required this.onSelected});

  final ScrollController scrollController;
  final Function(int) onSelected;

  @override
  State<SelectionListWidget> createState() => _SelectionListWidgetState();
}

class _SelectionListWidgetState extends State<SelectionListWidget> {
  int _choiceValue = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 42,
        ),
        child: ListView.separated(
          controller: widget.scrollController,
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemBuilder: (context, index) {
            final e = staticRecentTitle[index];
            return SizedBox(
              height: 32,
              child: ChoiceChip.elevated(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                label: Text(e['title']),
                selected: _choiceValue == staticRecentTitle.indexOf(e),
                onSelected: (value) {
                  setState(() {
                    _choiceValue = staticRecentTitle.indexOf(e);
                    widget.onSelected(_choiceValue);
                  });
                },
                showCheckmark: false,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                visualDensity: VisualDensity.compact,
                labelStyle: themeData.textTheme.labelMedium!.copyWith(
                  color:
                      _choiceValue == staticRecentTitle.indexOf(e) ? Colors.white : themeData.colorScheme.onBackground,
                ),
                color: _choiceValue == staticRecentTitle.indexOf(e)
                    ? const MaterialStatePropertyAll(AppColors.primary)
                    : MaterialStatePropertyAll(themeData.colorScheme.background),
                elevation: 2,
              ),
            );
          },
          itemCount: staticRecentTitle.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
