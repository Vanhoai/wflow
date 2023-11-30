import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/enum/enum.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/task/function.dart';

import 'bloc/state.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({required this.idContract, super.key, required this.workId});

  final num idContract;
  final num workId;

  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskBloc taskBloc = instance.get<TaskBloc>();

  @override
  void initState() {
    super.initState();
    taskBloc.add(GetTaskEvent(idContract: widget.idContract));
  }

  final timeZero = DateTime.fromMillisecondsSinceEpoch(0);
  @override
  void dispose() {
    taskBloc.add(InitEvent());
    super.dispose();
  }

  Future _displayRating(BuildContext context, TaskBloc taskBloc) async {
    final ThemeData themeData = Theme.of(context);
    final UserEntity userEntity = instance.get<AppBloc>().state.userEntity;
    final TextEditingController ratingController = TextEditingController();
    double rating = 5;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return BlocBuilder<TaskBloc, TaskState>(
              buildWhen: (previous, current) => true,
              bloc: taskBloc,
              builder: (context, state) {
                return Theme(
                  data: themeData.copyWith(dialogBackgroundColor: themeData.colorScheme.background),
                  child: AlertDialog(
                    backgroundColor: themeData.colorScheme.background,
                    surfaceTintColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(10),
                    title: Text(instance.get<AppLocalization>().translate('rating') ?? 'Rating',
                        style: themeData.textTheme.displayMedium),
                    content: Container(
                      color: themeData.colorScheme.background,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.primary,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                rating = rating;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            style: Theme.of(context).textTheme.bodyLarge,
                            minLines: 3,
                            maxLines: 5,
                            // and this
                            textInputAction: TextInputAction.newline,
                            controller: ratingController,
                            decoration: InputDecoration(
                              hintText: instance.call<AppLocalization>().translate('ratingTypeContent') ?? 'Content',
                              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black26),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: AppColors.primary, width: 1.2),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.black26, width: 1.2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          PrimaryButton(
                            label:
                                instance.get<AppLocalization>().translate('ratingThisWork') ?? 'Rating this contract',
                            onPressed: () {
                              if (widget.workId == 0) {
                                AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'),
                                    instance.get<AppLocalization>().translate('ratingFailed'), callback: () {
                                  Navigator.pop(context);
                                });
                              }
                              taskBloc.add(RatingEvent(
                                star: rating,
                                description: ratingController.text,
                                businessID: userEntity.business,
                                userID: widget.workId,
                              ));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
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
                    _bottomSheetDetail(task, context);
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
                      style: Theme.of(context).textTheme.displayMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
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
              timeZero.microsecondsSinceEpoch == task.endTime.microsecondsSinceEpoch
                  ? ''
                  : instance.get<Time>().getDayMonthYear(task.endTime.toString()),
              style: Theme.of(context).textTheme.displayMedium!,
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
    final TaskStatus status0 = TaskStatus.values.firstWhere((element) => element.name == status);

    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black26),
        borderRadius: BorderRadius.circular(6.0),
        color: colorStatus(status0),
      ),
      child: iconStatus(status0),
    );
  }

  Future _bottomSheetDetail(TaskEntity task, BuildContext context) {
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
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  instance.get<AppLocalization>().translate('mission') ?? 'Mission',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Text(
                task.title.isNotEmpty ? task.title : 'Không có thông tin',
                style: Theme.of(context).textTheme.displayMedium,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 10),
                  child: Text(
                    instance.get<AppLocalization>().translate('description') ?? 'Description',
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
                        task.content.isNotEmpty
                            ? task.content
                            : instance.get<AppLocalization>().translate('noInfo') ?? 'No info',
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
                  '${instance.get<AppLocalization>().translate('deadlineAt') ?? 'Deadline'}: ${instance.get<Time>().getDayMonthYear(task.endTime.toString())}',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: task.state == TaskStatus.Accepted.toString() ? AppColors.greenColor : AppColors.redColor,
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
                      instance.get<AppLocalization>().translate('cancel') ?? 'Cancel',
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
                    child: Text(
                      instance.get<AppLocalization>().translate('done') ?? 'Done',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
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
                      instance.get<AppLocalization>().translate('taskRejected') ?? 'Reject',
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

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => taskBloc,
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {},
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading || current is GetTaskListSuccessState && current.isAllDone,
        bloc: taskBloc,
        buildWhen: (previous, current) => previous.isLoading != current.isLoading,
        builder: (context, state) {
          return CommonScaffold(
            appBar: AppHeader(
              text: Text(
                instance.get<AppLocalization>().translate('task') ?? 'Task',
                style: themeData.textTheme.displayMedium,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async => taskBloc..add(GetTaskEvent(idContract: widget.idContract)),
              child: Stack(
                children: [
                  Builder(
                    builder: (context) {
                      if (state is GetTaskListSuccessState) {
                        if (state.taskEntities.isEmpty) {
                          return Center(
                            child: Text(
                              instance.get<AppLocalization>().translate('noTask') ?? 'No task',
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
                                if (state.stateContract == ContractStatus.Success.name &&
                                    instance.get<AppBloc>().state.role != RoleEnum.user.index + 1) {
                                  return Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(20),
                                    child: PrimaryButton(
                                      label: instance.get<AppLocalization>().translate('rating') ?? 'Rating',
                                      onPressed: () {
                                        _displayRating(context, instance.get<TaskBloc>());
                                      },
                                    ),
                                  );
                                } else {
                                  if (state.isAllDone &&
                                      instance.get<AppBloc>().state.role != RoleEnum.user.index + 1) {
                                    return Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(20),
                                      child: PrimaryButton(
                                        label: instance.get<AppLocalization>().translate('closeContract') ??
                                            'Close contract',
                                        onPressed: () {
                                          taskBloc.add(CheckContractAndTransfer(id: widget.idContract));
                                        },
                                      ),
                                    );
                                  }
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  Positioned(
                    child: Visibility(
                      visible: state.isLoading && state is! RatingState && state is! RatingSuccessState,
                      child: const LoadingWithWhite(),
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
}
