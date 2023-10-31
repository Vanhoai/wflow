import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/extensions/regex.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/task/task_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/task_create_contract.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key, required this.contract});

  final String contract;

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController budgetController;

  bool validator() {
    if (titleController.text.isEmpty) {
      AlertUtils.showMessage('Notification', 'Please enter title');
      return false;
    }
    if (budgetController.text.isEmpty) {
      AlertUtils.showMessage('Notification', 'Something went wrong with budget');
      return false;
    }

    if (!budgetController.text.isNumber()) {
      AlertUtils.showMessage('Notification', 'Budget must be a number');
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: '');
    descriptionController = TextEditingController(text: '');
    budgetController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    super.dispose();
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
        appBar: const AppHeader(text: 'Create Contract'),
        hideKeyboardWhenTouchOutside: true,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  Future.delayed(const Duration(seconds: 1));
                },
                child: CustomScrollView(
                  clipBehavior: Clip.none,
                  cacheExtent: 1000,
                  dragStartBehavior: DragStartBehavior.start,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    BlocConsumer<CreateContractBloc, CreateContractState>(
                      listener: (context, state) {
                        if (state.initSuccess) {
                          titleController.text = state.contractEntity.title;
                          descriptionController.text = state.contractEntity.content;
                          budgetController.text = state.contractEntity.salary;
                        }
                      },
                      builder: (context, state) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Title',
                                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                    color: themeData.colorScheme.onBackground,
                                  )),
                                ),
                                const SizedBox(height: 8),
                                TextFieldHelper(
                                  controller: titleController,
                                  maxLines: 2,
                                  minLines: 1,
                                  hintText: 'Enter project title',
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Describe',
                                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                    color: themeData.colorScheme.onBackground,
                                  )),
                                ),
                                const SizedBox(height: 8),
                                TextFieldHelper(
                                  controller: descriptionController,
                                  maxLines: 5,
                                  minLines: 3,
                                  hintText: 'Enter description (optional)',
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Budget',
                                  style: themeData.textTheme.displayMedium!.merge(
                                    TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFieldHelper(
                                  controller: budgetController,
                                  maxLines: 1,
                                  minLines: 1,
                                  hintText: 'Enter budget for project',
                                ),
                                const SizedBox(height: 20),
                                const TaskCreateContract(),
                                const SizedBox(height: 16),
                                ActionHelper(onUpload: () {}, onWatchVideo: () {}),
                                const SizedBox(height: 30),
                                Text(
                                  'Candidate',
                                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                    color: themeData.colorScheme.onBackground,
                                  )),
                                ),
                                const SizedBox(height: 10),
                                Header(
                                  title: Text(
                                    'Trần Văn Hoài',
                                    style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    )),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    'hoaitvps22068@fpt.edu.vn',
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
                        return PrimaryButton(
                          label: 'Create',
                          onPressed: () {
                            final bool isValid = validator();
                            if (isValid) {
                              context.read<CreateContractBloc>().add(
                                    CreateNewContractEvent(
                                      contract: int.parse(widget.contract),
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      budget: num.parse(budgetController.text),
                                    ),
                                  );
                            }
                          },
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
