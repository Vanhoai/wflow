import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TaskCreateContractWidget extends StatefulWidget {
  const TaskCreateContractWidget({super.key});

  @override
  State<TaskCreateContractWidget> createState() => _TaskCreateContractWidgetState();
}

class _TaskCreateContractWidgetState extends State<TaskCreateContractWidget> {
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
          size: 20,
          color: Colors.green,
        ),
      ),
      builder: TimelineTileBuilder.connectedFromStyle(
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
                SizedBox(
                  width: 18,
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: themeData.colorScheme.onBackground,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 90,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
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
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: Text('10/10/2021 - 10/11/2021'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
      ),
    );
  }
}
