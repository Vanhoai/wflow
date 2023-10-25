import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:wflow/core/theme/colors.dart';

class TaskCreateContractWidget extends StatefulWidget {
  const TaskCreateContractWidget({super.key});

  @override
  State<TaskCreateContractWidget> createState() => _TaskCreateContractWidgetState();
}

class _TaskCreateContractWidgetState extends State<TaskCreateContractWidget> {
  void showCalendar() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          height: 400,
          child: CupertinoDatePicker(
            backgroundColor: Colors.white,
            onDateTimeChanged: (value) {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return FixedTimeline.tileBuilder(
      mainAxisSize: MainAxisSize.min,
      theme: TimelineThemeData(
        connectorTheme: const ConnectorThemeData(
          thickness: 1,
        ),
        indicatorTheme: const IndicatorThemeData(
          size: 12,
          color: Colors.green,
        ),
      ),
      builder: TimelineTileBuilder.connectedFromStyle(
        contentsAlign: ContentsAlign.basic,
        indicatorPositionBuilder: (context, index) {
          if (index == 5) {
            return 0;
          }
          return 0.5;
        },
        nodePositionBuilder: (context, index) => 0,
        lastConnectorStyle: ConnectorStyle.solidLine,
        firstConnectorStyle: ConnectorStyle.solidLine,
        connectorStyleBuilder: (context, index) {
          if (index == 5) {
            return ConnectorStyle.transparent;
          }
          return ConnectorStyle.solidLine;
        },
        indicatorStyleBuilder: (context, index) {
          if (index == 5) {
            return IndicatorStyle.container;
          }
          return IndicatorStyle.dot;
        },
        itemExtentBuilder: (context, index) {
          if (index == 5) {
            return 20;
          }
          return 100;
        },
        itemCount: 6,
        contentsBuilder: (context, index) {
          if (index == 5) {
            return const SizedBox();
          }
          return SizedBox(
            height: 90,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 18,
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.borderColor,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 20),
                                Text(
                                  'Task 1',
                                  style: themeData.textTheme.displayMedium!.merge(
                                    TextStyle(
                                      color: themeData.colorScheme.background,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '1/5',
                                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                    color: themeData.colorScheme.background,
                                  )),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: showCalendar,
                                child: const Text('12-12-2023'),
                              ),
                              const SizedBox(width: 12),
                              const Text('12-12-2023'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
