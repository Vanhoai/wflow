import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class ContractWaitingSignScreen extends StatefulWidget {
  const ContractWaitingSignScreen({super.key});

  @override
  State<ContractWaitingSignScreen> createState() => _ContractWaitingSignScreenState();
}

class _ContractWaitingSignScreenState extends State<ContractWaitingSignScreen> {
  void onClear() {}

  void onSearch(String value) {
    print('searching $value');
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: const AppHeader(text: 'Contract Waiting Sign'),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SharedSearchBar(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              onClear: onClear,
              onSearch: onSearch,
            ),
          ],
        ),
      ),
    );
  }
}
