import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class UpPostScreen extends StatefulWidget {
  const UpPostScreen({super.key});

  @override
  State<UpPostScreen> createState() => _UpPostScreenState();
}

class _UpPostScreenState extends State<UpPostScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _budgetController;

  @override
  void initState() {
    _titleController = TextEditingController(text: '');
    _descriptionController = TextEditingController(text: '');
    _budgetController = TextEditingController(text: '');
    super.initState();
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
      create: (_) => UpPostBloc(),
      child: CommonScaffold(
        appBar: const AppHeader(text: 'Up Post'),
        hideKeyboardWhenTouchOutside: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              CustomScrollView(
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
                            keyboardType: TextInputType.number,
                            suffixIcon: const Icon(Icons.attach_money_sharp),
                          ),
                          const SizedBox(height: 20),
                          const TaskCreatePost(),
                          const SizedBox(height: 20),
                          ActionHelper(onUpload: () {}, onWatchVideo: () {}),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
