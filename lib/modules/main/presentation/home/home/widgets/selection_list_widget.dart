import 'package:flutter/material.dart';

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    setState(() {
      _choiceValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 42,
        ),
        child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemBuilder: (context, index) {
            final e = staticRecentTitle[index];
            return SizedBox(
              height: 28,
              child: ChoiceChip.elevated(
                label: Text(e['title']),
                selected: _choiceValue == staticRecentTitle.indexOf(e),
                onSelected: (value) {
                  setState(() {
                    _choiceValue = staticRecentTitle.indexOf(e);
                    onSelected(_choiceValue);
                  });
                },
                showCheckmark: false,
                labelPadding: EdgeInsets.zero,
                // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                visualDensity: VisualDensity.compact,
                labelStyle: themeData.textTheme.titleMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color:
                      _choiceValue == staticRecentTitle.indexOf(e) ? Colors.white : themeData.colorScheme.onBackground,
                ),
                color: _choiceValue == staticRecentTitle.indexOf(e)
                    ? MaterialStatePropertyAll(Colors.blue.withOpacity(0.5))
                    : MaterialStatePropertyAll(themeData.colorScheme.background),
                elevation: 2,
              ),
            );
          },
          itemCount: staticRecentTitle.length,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 20.0),
        ),
      ),
    );
  }
}
