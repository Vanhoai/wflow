import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key, required this.contract});

  final String contract;

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    _descriptionController = TextEditingController(text: '');
    _budgetController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => CreateContractBloc(
        contractUseCase: instance.get<ContractUseCase>(),
      )..add(CreateContractInitEvent()),
      child: CommonScaffold(
        appBar: const AppHeader(text: 'Create Contract'),
        hideKeyboardWhenTouchOutside: true,
        body: Stack(
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
                  SliverToBoxAdapter(
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
                            controller: _titleController,
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
                            controller: _descriptionController,
                            maxLines: 5,
                            minLines: 3,
                            hintText: 'Enter basic description for project',
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
                            controller: _budgetController,
                            maxLines: 1,
                            minLines: 1,
                            hintText: 'Enter budget for project',
                            suffixIcon: const Icon(Icons.attach_money_sharp),
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
                  ),
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
                  child: PrimaryButton(
                    label: 'Create',
                    onPressed: () {},
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
