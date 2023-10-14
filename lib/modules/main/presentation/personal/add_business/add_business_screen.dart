import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/widgets/add_business_card.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/widgets/search_add_business.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/utils/constants.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  TextEditingController controller = TextEditingController();
  bool isHiddenSuffixIcon = true;

  void onCheck(value, id) => setState(() {
        for (int i = 0; i < users.length; i++) {
          if (users[i]['id'].toString() == id.toString()) {
            users[i]['isCheck'] = value;
            break;
          }
        }

        for (int i = 0; i < foundUsers.length; i++) {
          if (foundUsers[i]['id'].toString() == id.toString()) {
            foundUsers[i]['isCheck'] = value;
            break;
          }
        }
      });

  void onChangedSearch(String value) {
    List<Map<String, dynamic>> result = [];

    if (value.isEmpty) {
      result = users;
    } else {
      result = users
          .where((user) => user['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      isHiddenSuffixIcon = value.isEmpty;
      foundUsers = result;
    });
  }

  void onClearSearch() => setState(() {
        isHiddenSuffixIcon = true;
        foundUsers = users;
        controller.clear();
      });

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
            SearchAddBusiness(
              controller: controller,
              isHiddenSuffixIcon: isHiddenSuffixIcon,
              onChangedSearch: onChangedSearch,
              onClearSearch: onClearSearch,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundUsers.length,
                itemBuilder: (context, index) {
                  return AddBusinessCard(
                    image: foundUsers[index]['image'],
                    name: foundUsers[index]['name'],
                    email: foundUsers[index]['email'],
                    isCheck: foundUsers[index]['isCheck'],
                    onCheck: (value) => onCheck(value, foundUsers[index]['id']),
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
