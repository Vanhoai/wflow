import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      isSafe: true,
      appBar: AppHeader(
        text: Text(
          'Applied',
          style: themeData.textTheme.displayMedium,
        ),
      ),
      body: Container(),
    );
  }
}
