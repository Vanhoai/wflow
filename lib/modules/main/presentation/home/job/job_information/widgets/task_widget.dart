import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

const String _kProgress = '\u2022';

class TaskWidget extends StatelessWidget {
  final List<String> tasks;
  const TaskWidget({required this.tasks, super.key});
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
            '📑 Task',
            style: themeData.textTheme.displayLarge!.merge(TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
            )),
          ),
          6.verticalSpace,
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TextMore(
                  '${(index + 1).toString()}. ${tasks[index]}',
                  style: themeData.textTheme.displayLarge!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16,
                    ),
                  ),
                  trimMode: TrimMode.Line,
                  trimLines: 7,
                );
              },
              separatorBuilder: (BuildContext context, int index) => 10.verticalSpace,
            ),
          ),
        ],
      ),
    );
  }
}
