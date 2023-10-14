import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/contract/create_contract/widgets/widget.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key});

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
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: RefreshIndicator(
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
            SliverAppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, false),
              ),
              surfaceTintColor: Colors.transparent,
              pinned: true,
            ),
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
                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
                    ),
                    const SizedBox(height: 10),
                    TextFieldCreateContractWidget(
                      controller: _titleController,
                      maxLines: 5,
                      minLines: 3,
                      hintText: 'Enter project title',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Describe',
                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
                    ),
                    const SizedBox(height: 10),
                    TextFieldCreateContractWidget(
                      controller: _descriptionController,
                      maxLines: 5,
                      minLines: 3,
                      hintText: 'Enter basic description for project',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Budget',
                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
                    ),
                    const SizedBox(height: 10),
                    TextFieldCreateContractWidget(
                      controller: _budgetController,
                      maxLines: 1,
                      minLines: 1,
                      hintText: 'Enter budget for project',
                      suffixIcon: const Icon(
                        Icons.attach_money_sharp,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Task',
                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
                    ),
                    const SizedBox(height: 10),
                    const TaskCreateContractWidget(),
                    const SizedBox(height: 16),
                    const ActionCreateContractWidget(),
                    const SizedBox(height: 30),
                    Text(
                      'Candidate',
                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
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
                      onTapTitle: () {},
                      leadingBadge: false,
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      label: 'Create',
                      onPressed: () {},
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
