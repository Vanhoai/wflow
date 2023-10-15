import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/widgets/chat_business_card.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/widgets/search_chat_business.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/utils/constants.dart';

class ChatBusinessScreen extends StatefulWidget {
  const ChatBusinessScreen({super.key});

  @override
  State<ChatBusinessScreen> createState() => _ChatBusinessScreenState();
}

class _ChatBusinessScreenState extends State<ChatBusinessScreen> {
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

  void onChangedSearch(String value) {
    List<Map<String, dynamic>> result = [];

    if (value.isEmpty) {
      result = users;
    } else {
      result = users.where((user) => user['name'].toString().toLowerCase().contains(value.toLowerCase())).toList();
    }

    setState(() {
      _isHiddenSuffixIcon = value.isEmpty;
      foundUsers = result;
    });
  }

  void onClearSearch() {
    setState(() {
      _isHiddenSuffixIcon = true;
      foundUsers = users;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat for business'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            SearchChatBusiness(
              controller: _controller,
              isHiddenSuffixIcon: _isHiddenSuffixIcon,
              onChangedSearch: (value) => onChangedSearch(value),
              onClearSearch: () => onClearSearch(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundUsers.length,
                itemBuilder: ((context, index) {
                  return ChatBusinessCard(
                    image: foundUsers[index]['image'],
                    name: foundUsers[index]['name'],
                    message: foundUsers[index]['message'],
                    time: foundUsers[index]['time'],
                    quantity: foundUsers[index]['quantity'],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
