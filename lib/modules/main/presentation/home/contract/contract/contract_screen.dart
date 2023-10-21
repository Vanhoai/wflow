import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/utils/constants.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/widgets/contract_card.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/widgets/search_contract.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  late TextEditingController _controller;
  late bool _isHiddenSuffixIcon;

  @override
  void initState() {
    _controller = TextEditingController();
    _isHiddenSuffixIcon = true;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChangedSearch(String value) {
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
      _isHiddenSuffixIcon = value.isEmpty;
      foundContracts = result;
    });
  }

  void _onClearSearch() {
    setState(() {
      _isHiddenSuffixIcon = true;
      foundContracts = contracts;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SearchContract(
              controller: _controller,
              isHiddenSuffixIcon: _isHiddenSuffixIcon,
              onChangedSearch: (value) => _onChangedSearch(value),
              onClearSearch: () => _onClearSearch,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
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
