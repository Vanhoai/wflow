import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/components/chat_business_card.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/components/search_chat_business.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/utils/constants.dart';

class ChatBusiness extends StatefulWidget {
  const ChatBusiness({super.key});

  @override
  State<ChatBusiness> createState() => _ChatBusinessState();
}

class _ChatBusinessState extends State<ChatBusiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat for business'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            const SearchChatBusiness(),
            Expanded(
              child: ListView.builder(
                itemCount: userChats.length,
                itemBuilder: ((context, index) {
                  return ChatBusinessCard(
                    image: userChats[index][0],
                    name: userChats[index][1],
                    message: userChats[index][2],
                    time: userChats[index][3],
                    quantity: userChats[index][4],
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
