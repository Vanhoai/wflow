import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/components/add_business_card.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/components/search_add_business.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/utils/constants.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  void onCheck(value, index) {
    setState(() {
      users[index][3] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to business'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SearchAddBusiness(),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return AddBusinessCard(
                    image: users[index][0],
                    name: users[index][1],
                    email: users[index][2],
                    isCheck: users[index][3],
                    onCheck: (value) => onCheck(value, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
