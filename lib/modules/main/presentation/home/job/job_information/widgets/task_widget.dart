import 'package:flutter/material.dart';

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
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              fontSize: 18,
            )),
          ),
          const SizedBox(
            height: 13,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Text(
                    '${(index + 1).toString()}.  ',
                    style: themeData.textTheme.displayMedium!.merge(
                      TextStyle(
                        color: themeData.colorScheme.onBackground,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tasks[index],
                      style: themeData.textTheme.displayLarge!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            clipBehavior: Clip.antiAliasWithSaveLayer,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}
