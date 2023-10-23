import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/work/work/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/work/work/widgets/widgets.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkBloc(postUseCase: instance.get<PostUseCase>())..add(WorkInitialEvent()),
      child: const CommonScaffold(
        hideKeyboardWhenTouchOutside: true,
        isSafe: true,
        body: Column(
          children: [
            HeaderBarWidget(),
            ListWorks(),
          ],
        ),
      ),
    );
  }
}
