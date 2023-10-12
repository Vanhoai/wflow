import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/work/work/widgets/widgets.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  // ignore: unused_field
  String _searchText = '';

  void onSearch(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      isSafe: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void>.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            const HeaderBarWidget(),
            SearchBarWidget(
              onSearch: onSearch,
            ),
            const ListResultWidget(),
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
