import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/enum/enum.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/alert.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/task/task_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/shimmer_create_contract.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/task_create_contract.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key, required this.contract});

  final String contract;

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {
  late final bool isBusiness;

  @override
  void initState() {
    super.initState();
    isBusiness = instance.get<AppBloc>().state.role == RoleEnum.business.index + 1;
  }

  bool canEdit(ContractStatus status) {
    switch (status) {
      case ContractStatus.Apply:
      case ContractStatus.Created:
        return true;
      case ContractStatus.WaitingSign:
      case ContractStatus.Accepted:
      case ContractStatus.Success:
      case ContractStatus.Rejected:
        return false;
      default:
        return false;
    }
  }

  Future<void> choseExcelFile(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xls', 'xlsx', 'xlsm']);
    if (result != null) {
      File file = File(result.files.single.path!);
      if (context.mounted) {
        context.read<CreateContractBloc>().add(AddTaskWithExcel(contract: num.parse(widget.contract), file: file));
      }
    } else {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => CreateContractBloc(
        contractUseCase: instance.get<ContractUseCase>(),
        taskUseCase: instance.get<TaskUseCase>(),
      )..add(CreateContractInitEvent(contract: widget.contract)),
      child: CommonScaffold(
        appBar: AppHeader(
          text: Text(
            instance.get<AppLocalization>().translate(isBusiness ? 'createContract' : 'contractDetail') ??
                'Create Contract',
            style: themeData.textTheme.displayMedium,
          ),
        ),
        hideKeyboardWhenTouchOutside: true,
        body: BlocBuilder<CreateContractBloc, CreateContractState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Builder(builder: (context) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<CreateContractBloc>().add(CreateContractInitEvent(contract: widget.contract));
                      },
                      child: Visibility(
                        visible: !state.isLoading,
                        replacement: const ShimmerCreateContract(),
                        child: CustomScrollView(
                          clipBehavior: Clip.none,
                          cacheExtent: 1000,
                          dragStartBehavior: DragStartBehavior.start,
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            BlocConsumer<CreateContractBloc, CreateContractState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                final ContractStatus status = ContractStatus.values.firstWhere(
                                  (element) => element.name.toString() == state.contractEntity.state.toString(),
                                  orElse: () => ContractStatus.WaitingSign,
                                );

                                return SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          instance.get<AppLocalization>().translate('title') ?? 'Title',
                                          style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                            color: themeData.colorScheme.onBackground,
                                          )),
                                        ),
                                        const SizedBox(height: 8),
                                        TextFieldHelper(
                                          enabled: isBusiness && canEdit(status),
                                          controller: context.read<CreateContractBloc>().titleController,
                                          maxLines: 2,
                                          minLines: 1,
                                          hintText:
                                              instance.get<AppLocalization>().translate('enterTitle') ?? 'Enter title',
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          instance.get<AppLocalization>().translate('description') ?? 'Description',
                                          style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                            color: themeData.colorScheme.onBackground,
                                          )),
                                        ),
                                        const SizedBox(height: 8),
                                        TextFieldHelper(
                                          enabled: isBusiness && canEdit(status),
                                          controller: context.read<CreateContractBloc>().descriptionController,
                                          maxLines: 5,
                                          minLines: 3,
                                          hintText: instance.get<AppLocalization>().translate('enterDescription') ??
                                              'Enter description',
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          instance.get<AppLocalization>().translate('budget') ?? 'Budget' ' (VNĐ)',
                                          style: themeData.textTheme.displayMedium!.merge(
                                            TextStyle(
                                              color: themeData.colorScheme.onBackground,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextFieldHelper(
                                          enabled: isBusiness && canEdit(status),
                                          controller: context.read<CreateContractBloc>().budgetController,
                                          maxLines: 1,
                                          minLines: 1,
                                          hintText: instance.get<AppLocalization>().translate('enterBudget') ??
                                              'Enter budget',
                                          keyboardType: TextInputType.number,
                                          onChange: (value) {
                                            context.read<CreateContractBloc>().add(GetMoney());
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          '${instance.get<AppLocalization>().translate("budgetTheWorkerHave")} (VNĐ)',
                                          style: themeData.textTheme.displayMedium!.merge(
                                            TextStyle(
                                              color: themeData.primaryColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.fromLTRB(13, 15, 13, 15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.grey[100],
                                          ),
                                          child: Text(
                                            state.money,
                                            style: themeData.textTheme.displayMedium!.merge(
                                              const TextStyle(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TaskCreateContract(
                                          isEnabled: isBusiness && canEdit(status),
                                        ),
                                        const SizedBox(height: 16),
                                        Visibility(
                                          visible:
                                              isBusiness && state.contractEntity.state == ContractStatus.Apply.name,
                                          child: ActionHelper(onUpload: () {
                                            choseExcelFile(context);
                                          }, onWatchVideo: () {
                                            Navigator.of(context).pushNamed(RouteKeys.guileUseExcelScreen);
                                          }),
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              instance.get<AppLocalization>().translate('worker') ?? 'Worker',
                                              style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                                color: themeData.colorScheme.onBackground,
                                              )),
                                            ),
                                            Text(
                                              state.contractEntity.workerSigned
                                                  ? '🥰️ ${instance.get<AppLocalization>().translate('accepted') ?? 'Accepted'}'
                                                  : '😪️ ${instance.get<AppLocalization>().translate('notAccepted') ?? 'Not Accepted'}',
                                              style: themeData.textTheme.displayMedium!,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Header(
                                          leadingPhotoUrl: state.contractEntity.worker.avatar,
                                          title: Text(
                                            state.contractEntity.worker.name,
                                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                              color: themeData.colorScheme.onBackground,
                                            )),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            state.contractEntity.worker.email,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                              color: themeData.colorScheme.onBackground,
                                            )),
                                          ),
                                          onTapLeading: () {},
                                          leadingBadge: false,
                                        ),
                                        32.verticalSpace,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              instance.get<AppLocalization>().translate('business') ?? 'Business',
                                              style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                                color: themeData.colorScheme.onBackground,
                                              )),
                                            ),
                                            Text(
                                              state.contractEntity.businessSigned
                                                  ? '🥰️ ${instance.get<AppLocalization>().translate('accepted') ?? 'Accepted'}'
                                                  : '😪️ ${instance.get<AppLocalization>().translate('notAccepted') ?? 'Not Accepted'}',
                                              style: themeData.textTheme.displayMedium!,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Header(
                                          leadingPhotoUrl: state.contractEntity.business.logo,
                                          title: Text(
                                            state.contractEntity.business.name,
                                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                              color: themeData.colorScheme.onBackground,
                                            )),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            state.contractEntity.business.email,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                              color: themeData.colorScheme.onBackground,
                                            )),
                                          ),
                                          onTapLeading: () {},
                                          leadingBadge: false,
                                        ),
                                        const SizedBox(height: 80),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  if (state is AppShowLoadingState) ...[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(themeData.colorScheme.background),
                        ),
                        child: const Center(
                          child: CupertinoActivityIndicator(
                            radius: 10,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
                      child: Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: themeData.colorScheme.background,
                          ),
                          child: BlocBuilder<CreateContractBloc, CreateContractState>(
                            builder: (context, state) {
                              return Builder(
                                builder: (context) {
                                  if (isBusiness) {
                                    if (state.contractEntity.state == ContractStatus.Apply.name) {
                                      print('state.contractEntity ${state.contractEntity.tasks}');
                                      return PrimaryButton(
                                        label: instance.get<AppLocalization>().translate('createContract') ??
                                            'Create Contract',
                                        width: double.infinity,
                                        onPressed: () {
                                          final bool isValid = context.read<CreateContractBloc>().validator();
                                          if (isValid) {
                                            context.read<CreateContractBloc>().add(
                                                  CreateNewContractEvent(
                                                    contract: int.parse(widget.contract),
                                                    title: context.read<CreateContractBloc>().titleController.text,
                                                    description:
                                                        context.read<CreateContractBloc>().descriptionController.text,
                                                    budget:
                                                        context.read<CreateContractBloc>().budgetController.numberValue,
                                                  ),
                                                );
                                          }
                                        },
                                      );
                                    } else if (state.contractEntity.state != ContractStatus.Accepted.name) {
                                      return PrimaryButton(
                                        label: instance.get<AppLocalization>().translate('accept') ?? 'Accept',
                                        width: double.infinity,
                                        onPressed: () {
                                          context.read<CreateContractBloc>().add(ContractCreatedBusinessSignEvent());
                                        },
                                      );
                                    } else {
                                      return PrimaryButton(
                                        label: instance.get<AppLocalization>().translate('viewProgress') ??
                                            'View Progress',
                                        width: double.infinity,
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(RouteKeys.taskScreen, arguments: {
                                            'contractId': state.contractEntity.id,
                                            'candidateId': state.contractEntity.worker.id,
                                          });
                                        },
                                      );
                                    }
                                  } else {
                                    if (state.contractEntity.state == ContractStatus.WaitingSign.name) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white60,
                                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    context.read<CreateContractBloc>().add(RejectContract());
                                                  },
                                                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                  child: Container(
                                                    height: 48,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      instance.get<AppLocalization>().translate('reject') ?? 'Reject',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.w400),
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
                                            child: PrimaryButton(
                                              label: instance.get<AppLocalization>().translate('accept') ?? 'Accept',
                                              width: double.infinity,
                                              onPressed: () => context
                                                  .read<CreateContractBloc>()
                                                  .add(ContractCreatedWorkerSignEvent()),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return PrimaryButton(
                                        label: instance.get<AppLocalization>().translate('accepted') ?? 'Accepted',
                                        width: double.infinity,
                                        onPressed: () {},
                                      );
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
