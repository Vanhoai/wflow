import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines/timelines.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/bloc/bloc.dart';

class TaskCreatePost extends StatefulWidget {
  const TaskCreatePost({super.key});

  @override
  State<TaskCreatePost> createState() => _TaskCreatePostState();
}

class _TaskCreatePostState extends State<TaskCreatePost> {
  final TextEditingController taskController = TextEditingController();

  Future<void> enterTaskForPost(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const Text('Enter task'),
          content: SizedBox(
            width: 300,
            child: TextFormField(
              controller: taskController,
              decoration: const InputDecoration(
                hintText: 'Enter task',
              ),
            ),
          ),
          actions: [
            PrimaryButton(
              height: 50,
              label: 'OK',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<UpPostBloc, UpPostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task',
                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                    color: themeData.colorScheme.onBackground,
                  )),
                ),
                InkWell(
                  onTap: () => context.read<UpPostBloc>().add(UpPostAddTaskEvent('Simple task')),
                  child: Text(
                    'Add Task',
                    style: themeData.textTheme.displayMedium!.merge(
                      TextStyle(
                        color: themeData.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            FixedTimeline.tileBuilder(
              mainAxisSize: MainAxisSize.min,
              theme: TimelineThemeData(
                connectorTheme: const ConnectorThemeData(
                  thickness: 1,
                ),
                indicatorTheme: const IndicatorThemeData(
                  size: 16,
                  color: Colors.green,
                ),
              ),
              builder: TimelineTileBuilder.connectedFromStyle(
                contentsAlign: ContentsAlign.basic,
                indicatorPositionBuilder: (context, index) {
                  return 0.5;
                },
                nodePositionBuilder: (context, index) => 0,
                lastConnectorStyle: ConnectorStyle.dashedLine,
                firstConnectorStyle: ConnectorStyle.dashedLine,
                connectorStyleBuilder: (context, index) {
                  return ConnectorStyle.dashedLine;
                },
                indicatorStyleBuilder: (context, index) {
                  return IndicatorStyle.dot;
                },
                itemExtentBuilder: (context, index) {
                  return 100;
                },
                itemCount: state.tasks.length,
                contentsBuilder: (context, index) {
                  return SizedBox(
                    height: 90,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 32,
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.borderColor,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => enterTaskForPost(index),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: themeData.colorScheme.background,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.borderColor,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                state.tasks[index],
                                style: themeData.textTheme.displayMedium!.merge(
                                  const TextStyle(
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => context.read<UpPostBloc>().add(RemoveLastTaskEvent()),
              child: Text(
                'Remove Task',
                style: themeData.textTheme.displayMedium!.merge(
                  const TextStyle(
                    color: AppColors.redColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}