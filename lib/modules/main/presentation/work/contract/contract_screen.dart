import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/work/contract/utils/constants.dart';
import 'package:wflow/modules/main/presentation/work/contract/widgets/contract_card.dart';
import 'package:wflow/modules/main/presentation/work/contract/widgets/search_contract.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  TextEditingController controller = TextEditingController();
  bool isHiddenSuffixIcon = true;

  void onChangedSearch(String value) {
    List<Map<String, dynamic>> result = [];

    if (value.isEmpty) {
      result = contracts;
    } else {
      result = contracts
          .where((contract) => contract['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      isHiddenSuffixIcon = value.isEmpty;
      foundContracts = result;
    });
  }

  void onClearSearch() => setState(() {
        isHiddenSuffixIcon = true;
        foundContracts = contracts;
        controller.clear();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SearchContract(
              controller: controller,
              isHiddenSuffixIcon: isHiddenSuffixIcon,
              onChangedSearch: onChangedSearch,
              onClearSearch: onClearSearch,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundContracts.length,
                itemBuilder: (context, index) => ContractCard(
                  image: foundContracts[index]['image'],
                  name: foundContracts[index]['name'],
                  content: foundContracts[index]['content'],
                  status: foundContracts[index]['status'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
