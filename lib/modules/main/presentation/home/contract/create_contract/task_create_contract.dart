import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines/timelines.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class TaskCreateContract extends StatefulWidget {
  const TaskCreateContract({super.key, required this.isBusiness});

  final bool isBusiness;

  @override
  State<TaskCreateContract> createState() => _TaskCreateContractState();
}

class _TaskCreateContractState extends State<TaskCreateContract> {
  final TextEditingController taskController = TextEditingController();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  bool validate() {
    if (titleController.text.isEmpty) {
      showMessageWarning('Please enter task title');
      return false;
    }

    if (startTimeController.text.isEmpty) {
      showMessageWarning('Please select start time');
      return false;
    }

    if (endTimeController.text.isEmpty) {
      showMessageWarning('Please select end time');
      return false;
    }

    final DateTime startTime = DateTime.parse(startTimeController.text);
    final DateTime endTime = DateTime.parse(endTimeController.text);

    if (endTime.isBefore(startTime)) {
      showMessageWarning('End time must be after start time');
      return false;
    }

    return true;
  }

  void showMessageWarning(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Warning',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showDatePicker(int pickerType, Function setState) {
    // 0: start time
    // 1: end time
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Container(
          alignment: Alignment.center,
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width - 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 340,
                  child: CupertinoDatePicker(
                    itemExtent: 50,
                    backgroundColor: Colors.white,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    minimumDate: DateTime.now(),
                    minimumYear: DateTime.now().year,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (dateTime) {
                      if (pickerType == 0) {
                        startTimeController.text = dateTime.toString();
                      } else {
                        endTimeController.text = dateTime.toString();
                      }
                    },
                  ),
                ),
                PrimaryButton(
                  marginHorizontal: 20,
                  label: 'OK',
                  height: 48,
                  onPressed: () {
                    if (pickerType == 1) {
                      if (endTimeController.text.isNotEmpty && startTimeController.text.isNotEmpty) {
                        DateTime startTime = DateTime.parse(startTimeController.text);
                        DateTime endTime = DateTime.parse(endTimeController.text);

                        if (endTime.isBefore(startTime)) {
                          showMessageWarning('End time must be after start time');
                          return;
                        }
                      }
                    }

                    setState(() {});
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetEditTask(BuildContext parentContext, int index, num id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return FractionallySizedBox(
              heightFactor: 1,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                width: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Edit Task',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Task title',
                                  style: themeData.textTheme.displayMedium,
                                ),
                                const SizedBox(height: 8),
                                TextFieldHelper(
                                  enabled: widget.isBusiness,
                                  controller: titleController,
                                  minLines: 1,
                                  maxLines: 1,
                                  hintText: 'Enter task heading',
                                  keyboardType: TextInputType.name,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Task content (optional)',
                                  style: themeData.textTheme.displayMedium,
                                ),
                                const SizedBox(height: 8),
                                TextFieldHelper(
                                  enabled: widget.isBusiness,
                                  controller: contentController,
                                  minLines: 1,
                                  maxLines: 4,
                                  hintText: 'Enter task content',
                                  keyboardType: TextInputType.name,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Start time',
                                  style: themeData.textTheme.displayMedium,
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () {
                                    if (widget.isBusiness) showDatePicker(0, setState);
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[100],
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      startTimeController.text.isEmpty ? 'Select start time' : startTimeController.text,
                                      style: themeData.textTheme.displayMedium!.merge(
                                        TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'End time',
                                  style: themeData.textTheme.displayMedium,
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () {
                                    if (widget.isBusiness) showDatePicker(1, setState);
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[100],
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      endTimeController.text.isEmpty ? 'Select end time' : endTimeController.text,
                                      style: themeData.textTheme.displayMedium!.merge(
                                        TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                PrimaryButton(
                                  label: widget.isBusiness ? 'Update' : 'OK',
                                  onPressed: () {
                                    final bool isValid = validate();
                                    if (isValid) {
                                      if (widget.isBusiness) {
                                        parentContext.read<CreateContractBloc>().add(
                                              UpdateTaskCreateContractEvent(
                                                id: id,
                                                index: index,
                                                title: titleController.text,
                                                content: contentController.text,
                                                startTime:
                                                    DateTime.parse(startTimeController.text).millisecondsSinceEpoch,
                                                endTime: DateTime.parse(endTimeController.text).millisecondsSinceEpoch,
                                              ),
                                            );
                                      }

                                      // clear controllers
                                      titleController.clear();
                                      contentController.clear();
                                      startTimeController.clear();
                                      endTimeController.clear();
                                      Navigator.pop(context);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    titleController.dispose();
    contentController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
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
            Visibility(
              visible: widget.isBusiness,
              child: BlocBuilder<CreateContractBloc, CreateContractState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () => context.read<CreateContractBloc>().add(AddTaskCreateContractEvent()),
                    child: Text(
                      'Add Task',
                      style: themeData.textTheme.displayMedium!.merge(
                        TextStyle(
                          color: themeData.colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<CreateContractBloc, CreateContractState>(
          builder: (context, state) {
            return FixedTimeline.tileBuilder(
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
                            onTap: () {
                              titleController.text = state.tasks[index].title;
                              contentController.text = state.tasks[index].content;
                              startTimeController.text = state.tasks[index].startTime.toString();
                              endTimeController.text = state.tasks[index].endTime.toString();

                              showBottomSheetEditTask(context, index, state.tasks[index].id);
                            },
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
                                state.tasks[index].title,
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
            );
          },
        ),
        const SizedBox(height: 12),
        Visibility(
          visible: widget.isBusiness,
          child: BlocBuilder<CreateContractBloc, CreateContractState>(
            builder: (context, state) {
              return InkWell(
                onTap: () => context.read<CreateContractBloc>().add(RemoveLastTaskCreateContractEvent()),
                child: Text(
                  'Remove Task',
                  style: themeData.textTheme.displayMedium!.merge(
                    const TextStyle(
                      color: AppColors.redColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
