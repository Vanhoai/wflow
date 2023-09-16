

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';

//Test chat class



class MainChat extends StatefulWidget {
  const MainChat({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainChatState();
  }

}

class _MainChatState extends State<MainChat> {
  final String id = "2";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (
        BlocBuilder<MainChatBloc,MainChatState>(
          builder: (context,state){
            return ListView.builder(
              itemCount: state.listChat.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: state.listChat[index].id == "1"? Alignment.centerRight : Alignment.centerLeft,
                    child: _chat(state.listChat[index])
                );
              },
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
        return _textChat(message: message);
      case 'record' :
        return _voiceChat(message: message);
      case 'image' :
        return _imageChat(url: message.content);
      default :
        return _textChat(message: message);
    }
  }
  Widget _textChat({required Message message})
  {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: id == message.id ? AppColors.primary : AppColors.fadeText ,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message.content,
        style: TextTitle(
          fontWeight: FontWeight.w500,
          size: 14,
          colors: id == message.id ? Colors.white : Colors.white
        ),
      ),
    );
  }
  Widget _voiceChat({required Message message}) {
    return VoiceMessage(
      audioSrc: "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3",
      played: true, // To show played badge or not.
      me: true,
      showDuration: false,
      formatDuration: (duration) => duration.toString().substring(2, 7),// Set message side.
      onPlay: () {},
      meBgColor: id == message.id ? AppColors.primary : AppColors.fadeText,// Do something when voice played.
    );
  }
  Widget _imageChat({required String url}){
    return Image.network(
      url,
      width: 200,
    );
  }

}