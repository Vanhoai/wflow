import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
import 'package:wflow/modules/main/domain/task/task_usecase.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/event.dart';

import 'bloc/state.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({required this.idContract, super.key});
  final num idContract;
  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (context) =>
          TaskBloc(taskUseCase: instance.get<TaskUseCase>())..add(GetTaskEvent(idContract: widget.idContract)),
      child: BlocBuilder<TaskBloc, TaskState>(
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          return CommonScaffold(
            appBar: const AppHeader(text: 'Tasks'),
            body: RefreshIndicator(
              onRefresh: () async => context.read<TaskBloc>().add(GetTaskEvent(idContract: widget.idContract)),
              child: Stack(
                children: [
                  Builder(
                    builder: (context) {
                      if (state is GetTaskListSuccessState) {
                        if (state.taskEntities.isEmpty) {
                          return Center(
                            child: Text(
                              'No item task',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.taskEntities.length,
                            itemBuilder: (context, index) {
                              return _task(state.taskEntities[index], context);
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  Positioned(
                    child: Visibility(
                      visible: state.isLoading,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white.withOpacity(0.1),
                        child: const Loading(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _task(TaskEntity task, BuildContext context) {
    return Stack(children: [
      Container(
        width: 1,
        height: 110,
        margin: const EdgeInsets.only(left: 11),
        color: AppColors.borderColor.withAlpha(80),
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _boxStatus(task.state),
              const SizedBox(
                width: 19,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _showDetail(task, context);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 19),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: AppColors.borderColor.withAlpha(90))),
                    child: Text(
                      task.title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.displayMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            alignment: Alignment.centerRight,
            child: Text(
              instance.get<Time>().getDayMonthYear(task.endTime.toString()),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: task.state == 'Done' ? AppColors.greenColor : AppColors.redColor,
                  ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ]);
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
      case 'Done':
      case 'Accepted':
        return Padding(padding: const EdgeInsets.all(2), child: SvgPicture.asset(AppConstants.checkOutLine));
      case 'InProgress':
        return Padding(padding: const EdgeInsets.all(0), child: SvgPicture.asset(AppConstants.warning));
      case 'Reject':
        return Padding(padding: const EdgeInsets.all(4), child: SvgPicture.asset(AppConstants.danger));
      default:
        return Padding(padding: const EdgeInsets.all(2), child: SvgPicture.asset(AppConstants.checkOutLine));
    }
  }

  Color _colorSatus(String status) {
    switch (status) {
      case 'Created':
        return Colors.white;
      case 'Done':
      case 'Accepted':
        return AppColors.greenColor;
      case 'InProgress':
        return Colors.yellow;
      case 'Reject':
        return AppColors.redColor;
      default:
        return Colors.white;
    }
  }

  _showDetail(TaskEntity task, BuildContext context) {
    final ScrollController controller = ScrollController();
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    'Nhiệm vụ: ',
                    style: Theme.of(context).textTheme.displayMedium,
                  )),
              Text(
                task.title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 3),
                  child: Text(
                    'Mô tả: ',
                    style: Theme.of(context).textTheme.displayMedium,
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
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Deadline: ${instance.get<Time>().getDayMonthYear(task.endTime.toString())}',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: task.state == 'DONE' ? AppColors.greenColor : AppColors.redColor,
                      ),
                ),
              ),
              _buttonStatus(task.state),
            ],
          ),
        );
      },
    );
  }

  Widget _buttonStatus(String status) {
    switch (status) {
      case 'DONE':
      case 'Accepted':
      case 'InProgress':
        return const SizedBox();
      case 'Created':
        return _buttonRequest();
      case 'Reject':
        return _buttonReject();
      default:
        return const SizedBox();
    }
  }

  Widget _buttonRequest() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: const Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
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
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            height: 45,
            alignment: Alignment.center,
            child: const Text(
              'Done Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
