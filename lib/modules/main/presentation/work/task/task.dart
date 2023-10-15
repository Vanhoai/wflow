import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/bloc.dart';

import 'bloc/state.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const Header(text: 'Tasks'),
        body: BlocProvider(
          lazy: true,
          create: (context) => TaskBloc(),
          child: BlocBuilder<TaskBloc, TaskState>(
            buildWhen: (previous, current) => true,
            builder: (context, state) {
              return Container(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Stack(
                  children: [
                    Container(
                      width: 1,
                      margin: const EdgeInsets.only(left: 11, bottom: 48),
                      color: AppColors.borderColor.withAlpha(80),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listTask.length,
                      itemBuilder: (context, index) {
                        return _task(state.listTask[index], context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _task(Task task, BuildContext context) {
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
                  InkWell(
                    onTap: () {
                      _showDetail(task,context);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 21, horizontal: 19),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1,
                              color: AppColors.borderColor.withAlpha(90))),
                      child: Text(
                        task.title,
                        maxLines: 2,
                        style: textTitle(fontWeight: FontWeight.w500, size: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
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
        child: _iconStatus(status));
  }

  Widget _iconStatus(String status) {
    switch (status) {
      case "DONE":
        return Padding(
            padding: const EdgeInsets.all(2),
            child: SvgPicture.asset(AppConstants.checkOutLine));
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
  _showDetail (Task task, BuildContext context)
  {
    final ScrollController controller = ScrollController();
    return showModalBottomSheet(context: context,builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: Text(
                  "Nhiệm vụ: ",
                  style: textTitle(
                      size: 14,
                      fontWeight: FontWeight.w400,
                      colors: AppColors.fadeText),
                )),
            Text(
              task.title,
              style: textTitle(size: 16, fontWeight: FontWeight.w500),
            ),
            Container(
                margin: const EdgeInsets.only(top: 8, bottom: 3),
                child: Text(
                  "Mô tả: ",
                  style: textTitle(
                      size: 14,
                      fontWeight: FontWeight.w400,
                      colors: AppColors.fadeText),
                )),
            SizedBox(
              height: 160,
              child: Scrollbar(
                thumbVisibility: true,
                controller: controller,
                radius: const Radius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SingleChildScrollView(
                    controller: controller,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Text(
                      task.content,
                      style: textTitle(size: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                'Deadline: ${instance.get<Time>().getDayMonthYear(task.end)}',
                style: textTitle(
                    size: 14,
                    fontWeight: FontWeight.w500,
                    colors: task.status == "DONE" ?AppColors.greenColor : AppColors.redColor
                ),
              ),
            ),
            _buttonStatus(task.status),
          ],
        ),
      );
    },);
  }

  Widget _buttonStatus(String status) {
    switch (status) {
      case "NONE":
        return const SizedBox();
      case "DONE":
        return const SizedBox();
      case "REQUEST":
        return _buttonRequest();
      case "REJECT":
        return _buttonReject();
      default:
        return const SizedBox();
    }
  }

  Widget _buttonRequest(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap:() {
                print("hihi");
              },
              borderRadius:const BorderRadius.all(Radius.circular(8.0)),
              child:Ink(
                height: 45,
                decoration:  const BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Container(
                  // min sizes for Material buttons
                  alignment: Alignment.center,
                  child:  const Text(
                    "Reject",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),

            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: InkWell(
              onTap:() {
                print("hihi");
              },
              borderRadius:const BorderRadius.all(Radius.circular(8.0)),
              child:Ink(
                height: 45,
                decoration:  const BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Container(
                  // min sizes for Material buttons
                  alignment: Alignment.center,
                  child:  const Text(
                    "Done task",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),

            ),
          )
        ],
      ),
    );
  }

  Widget _buttonReject() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap:() {
          print("hihi");
        },
        borderRadius:const BorderRadius.all(Radius.circular(8.0)),
        child:Ink(
          height: 45,
          decoration:  const BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Container(
            // min sizes for Material buttons
            alignment: Alignment.center,
            child:  const Text(
              "Done task",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),

      ),
    );
  }
}

