import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/work/work/widgets/widgets.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      isSafe: true,
      body: Column(
        children: [
          HeaderBarWidget(),
          ListResultWidget(),
        ],
      ),
    );
  }
}
