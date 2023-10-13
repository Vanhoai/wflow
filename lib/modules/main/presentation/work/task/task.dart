import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';

class Task {
  final String title;
  final String content;
  final String end;
  final String status;

  Task({required this.title,
    required this.content,
    required this.end,
    required this.status});
}

final List<Task> data = [
  Task(
      title: "Design database for application and set up base resouce",
      content: "Mua source",
      end: DateTime.now().toString(),
      status: "REQUEST"),
  Task(
      title: "Design database for application and set up base resouce",
      content: "Mua source",
      end: DateTime.now().toString(),
      status: "REJECT"),
  Task(
      title: "Design database for application and set up base resouce",
      content: "Mua source",
      end: DateTime.now().toString(),
      status: "NONE"),
  Task(
      title: "Design database for application and set up base resouce",
      content: "Mua source",
      end: DateTime.now().toString(),
      status: "DONE"),
  Task(
      title: "Design database for application and set up base resouce",
      content: "Mua source",
      end: DateTime.now().toString(),
      status: "DONE"),
  Task(
      title: "Design database for application and set up base resouce",
      content: "Mua source",
      end: DateTime.now().toString(),
      status: "DONE"),
];

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const Header(text: 'Tasks'),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Stack(
            children: [
              Container(
                width: 1,
                margin: const EdgeInsets.only(left: 11,bottom: 42),
                color: AppColors.fade,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _task(data[index]);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _task(Task task) {
    return Column(
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _boxStatus(task.status),

            const SizedBox(
              width: 19,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 21, horizontal: 19),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: AppColors.fade)),
                    child: Text(
                      task.title,
                      maxLines: 2,
                      style: textTitle(fontWeight: FontWeight.w500, size: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          alignment: Alignment.centerRight,
          child: Text(
            instance.get<Time>().getDayMonthYear(task.end),
            style: textTitle(size: 15, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _boxStatus(String status) {
    return Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(6.0),
          color: _colorSatus(status),
        ),
        child: _iconStatus(status)
    );
  }

  Widget _iconStatus(String status) {
    switch (status) {
      case "DONE":
        return Padding(
            padding: const EdgeInsets.all(2),
            child: SvgPicture.asset(AppConstants.checkOutLine)
        );
      case "REQUEST":
        return Padding(
            padding: const EdgeInsets.all(0),
            child: SvgPicture.asset(AppConstants.warning));
      case "REJECT":
        return Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(AppConstants.danger));
      default:
        return Padding(
            padding: const EdgeInsets.all(2),
            child: SvgPicture.asset(AppConstants.checkOutLine));
    }
  }

  Color _colorSatus(String status) {
    switch (status) {
      case "NONE":
        return Colors.white;
      case "DONE":
        return AppColors.greenColor;
      case "REQUEST":
        return Colors.yellow;
      case "REJECT":
        return AppColors.redColor;
      default:
        return Colors.white;
    }
  }
}
