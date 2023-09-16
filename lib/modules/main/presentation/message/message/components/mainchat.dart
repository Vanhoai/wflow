

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';

//Test chat class
class Message extends Equatable {
  final String id;
  final String content;
  final String type;

  const Message({required this.id, required this.content, required this.type});


  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class MainChat extends StatefulWidget {
  const MainChat({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainChatState();
  }

}

class _MainChatState extends State<MainChat> {
  final String id = "1";
  List<Message> chat = [
    const Message(id: "1", content: "Hello", type: "text"),
    const Message(id: "2", content: "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3", type: "record"),
    const Message(id: "1", content: "https://vapa.vn/wp-content/uploads/2022/12/anh-3d-thien-nhien-003.jpg", type: "image"),
    const Message(id: "2", content: "Hello", type: "text"),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (
        ListView.builder(
          itemCount: chat.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(5),
              alignment: chat[index].id == "1"? Alignment.centerRight : Alignment.centerLeft,
              child: _chat(chat[index])
            );
          },
        )
    );
  }
  Widget _chat(Message message)
  {
    switch(message.type)
    {
      case 'text' :
        return _textChat(text: message.content);
      case 'record' :
        return _voiceChat(url: message.content);
      case 'image' :
        return _imageChat(url: message.content);
      default :
        return _textChat(text: message.content);
    }
  }
  Widget _textChat({required String text})
  {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextTitle(
          fontWeight: FontWeight.w500,
          size: 14,
        ),
      ),
    );
  }
  Widget _voiceChat({required String url}) {
    return VoiceMessage(
      audioSrc: "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3",
      played: true, // To show played badge or not.
      me: true,
      showDuration: false,
      formatDuration: (duration) => duration.toString().substring(2, 7),// Set message side.
      onPlay: () {},
      meBgColor: AppColors.primary,// Do something when voice played.
    );
  }
  Widget _imageChat({required String url}){
    return Image.network(
      url,
      width: 200,
    );
  }

}