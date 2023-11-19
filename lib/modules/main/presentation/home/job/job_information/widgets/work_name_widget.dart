import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkNameWidget extends StatelessWidget {
  final String workName;
  const WorkNameWidget({required this.workName, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '🚚 Work Name',
            style: themeData.textTheme.displayLarge!.merge(
              TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18,
              ),
            ),
          ),
          6.verticalSpace,
          Text(
            workName,
            style: themeData.textTheme.displayLarge!.merge(TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
            )),
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
