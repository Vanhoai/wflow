import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/bloc/event.dart';
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
  final String id = "1";
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (BlocBuilder<MainChatBloc, MainChatState>(
      builder: (context, state) {
        print(FocusManager.instance.primaryFocus?.hasPrimaryFocus);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _controller.animateTo(_controller.position.maxScrollExtent ,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut);
        });
        return Listener(
          onPointerDown: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
            context.read<BoxChatBloc>().add(HideAllShowEvent());
          },
          child: ListView.builder(
            itemCount: state.listChat.length,
            controller: _controller,
            itemBuilder: (context, index) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignment: state.listChat[index].id == "1"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child:
                      _chat(message: state.listChat[index], context: context));
            },
          ),
        );
      },
    ));
  }

  Widget _chat({required Message message, required BuildContext context}) {
    switch (message.type) {
      case 'text':
        return _textChat(message: message, context: context);
      case 'record':
        return _voiceChat(message: message);
      case 'image':
        return _imageChat(message: message);
      default:
        return _textChat(message: message, context: context);
    }
  }

  Widget _textChat({required Message message, required BuildContext context}) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: id == message.id ? AppColors.primary : AppColors.fade,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          message.content,
          style: TextTitle(
              fontWeight: FontWeight.w400,
              size: 14,
              colors: id == message.id ? Colors.white : Colors.black87),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 30,
          child: Text(
            instance.get<Time>().getHourMinute(message.createAt.toString()),
            style: TextTitle(
                colors: id == message.id ? Colors.white : AppColors.fadeText,
                size: 10),
          ),
        )
      ]),
    );
  }

  Widget _voiceChat({required Message message}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      VoiceMessage(
        audioSrc: message.content,
        played: true,
        // To show played badge or not.
        me: true,
        showDuration: false,
        formatDuration: (duration) => duration.toString().substring(2, 7),
        // Set message side.
        meBgColor:
            id == message.id ? AppColors.primary : const Color(0xFFBDBFBF),
      ),
      Container(
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
            color: const Color(0xFFBDBFBF),
            borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        width: 30,
        child: Text(
          instance.get<Time>().getHourMinute(message.createAt.toString()),
          style: TextTitle(colors: Colors.white, size: 9),
        ),
      )
    ]);
  }

  Widget _imageChat({required Message message}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            message.content,
            width: 200,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
              color: const Color(0xFFBDBFBF),
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          width: 30,
          child: Text(
            instance.get<Time>().getHourMinute(message.createAt.toString()),
            style: TextTitle(colors: Colors.white, size: 9),
          ),
        )
      ],
    );
  }
}
