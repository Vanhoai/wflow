import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/enum/enum.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    instance.get<TaskBloc>().add(CleanEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: instance.get<TaskBloc>()..add(GetTaskEvent(idContract: widget.idContract)),
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return CommonScaffold(
          appBar: const AppHeader(text: 'Tasks'),
          body: RefreshIndicator(
            onRefresh: () async => instance.get<TaskBloc>().add(GetTaskEvent(idContract: widget.idContract)),
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
                      return Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 15, bottom: 15),
                              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.taskEntities.length,
                                itemBuilder: (context, index) {
                                  return _task(state.taskEntities[index], context);
                                },
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (instance.get<AppBloc>().state.role != RoleEnum.user.index + 1 && state.isAllDone) {
                                return Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(20),
                                  child: PrimaryButton(
                                    label: 'Close Contract',
                                    onPressed: () {
                                      instance.get<TaskBloc>().add(CheckContractAndTransfer(id: widget.idContract));
                                    },
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Positioned(
                  child: Visibility(
                    visible: state.isLoading,
                    child: const LoadingWithWhite(),
                  ),
                )
              ],
            ),
          ),
        );
      },
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
                    color: task.state == TaskStatus.Accepted.name ? AppColors.greenColor : AppColors.redColor,
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
                        color: task.state == TaskStatus.Accepted ? AppColors.greenColor : AppColors.redColor,
                      ),
                ),
              ),
              _buttonStatus(context, task),
            ],
          ),
        );
      },
    );
  }

  Widget _iconStatus(String status) {
    if (status == TaskStatus.Accepted.name) {
      return Padding(padding: const EdgeInsets.all(2), child: SvgPicture.asset(AppConstants.checkOutLine));
    } else if (status == TaskStatus.Done.name) {
      return Padding(padding: const EdgeInsets.all(0), child: SvgPicture.asset(AppConstants.warning));
    } else if (status == TaskStatus.Reject.name) {
      return Padding(padding: const EdgeInsets.all(4), child: SvgPicture.asset(AppConstants.danger));
    } else {
      return Padding(padding: const EdgeInsets.all(2), child: SvgPicture.asset(AppConstants.checkOutLine));
    }
  }

  Color _colorSatus(String status) {
    if (status == TaskStatus.Accepted.name) {
      return AppColors.greenColor;
    } else if (status == TaskStatus.Done.name) {
      return Colors.yellow;
    } else if (status == TaskStatus.Reject.name) {
      return AppColors.redColor;
    } else {
      return Colors.white;
    }
  }

  Widget _buttonStatus(BuildContext context, TaskEntity taskEntity) {
    if (instance.get<AppBloc>().state.role == RoleEnum.user.index + 1) {
      if (taskEntity.state == TaskStatus.Accepted.name || taskEntity.state == TaskStatus.Done.name) {
        return const SizedBox();
      } else if (taskEntity.state == TaskStatus.Todo.name || taskEntity.state == TaskStatus.Reject.name) {
        return _buttonRequest(context, taskEntity.id);
      } else {
        return const SizedBox();
      }
    } else {
      if (taskEntity.state == TaskStatus.Done.name) {
        return _buttonHandler(context, taskEntity.id);
      } else {
        return const SizedBox();
      }
    }
  }

  Widget _buttonRequest(BuildContext context, num taskId) {
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
                  onTap: () {
                    Navigator.pop(context);
                    instance.get<TaskBloc>().add(UpdateTaskEvent(id: taskId, status: TaskStatus.Done.name));
                  },
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

  Widget _buttonHandler(BuildContext context, num taskId) {
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
                    instance.get<TaskBloc>().add(UpdateTaskEvent(id: taskId, status: TaskStatus.Reject.name));
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      'Reject',
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
                  onTap: () {
                    Navigator.pop(context);
                    instance.get<TaskBloc>().add(UpdateTaskEvent(id: taskId, status: TaskStatus.Accepted.name));
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: const Text(
                      'Accepted',
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
}
