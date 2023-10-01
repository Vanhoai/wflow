import 'package:flutter/material.dart';

final List<Map<String, dynamic>> staticRecentTitle = [
  {'title': 'All'},
  {'title': 'Part time'},
  {'title': 'Full time'},
  {'title': 'Remote'},
  {'title': 'Remote'},
  {'title': 'Remote'}
];

class SelectionList extends StatefulWidget {
  const SelectionList({super.key, required this.scrollController, required this.onSelected});

  final ScrollController scrollController;
  final Function(int) onSelected;

  @override
  State<SelectionList> createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  int _choiceValue = 0;
  late ScrollController _scrollController;
  late void Function(int) onSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = widget.scrollController;
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('reach the bottom');
      }
      if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('reach the top');
      }
    });
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
                  fontSize: 10,
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
