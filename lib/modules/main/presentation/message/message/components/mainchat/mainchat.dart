import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';

class MainChat extends StatefulWidget {
  const MainChat({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainChatState();
  }
}

class _MainChatState extends State<MainChat> {
  final String id = '1';

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (BlocBuilder<MainChatBloc, MainChatState>(
      builder: (context, state) {
        if (state is Scroll) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            scrollController.animateTo(scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
          });
        }
        return Listener(
          onPointerDown: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
            context.read<BoxChatBloc>().add(HideAllShowEvent());
          },
          child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            controller: scrollController,
            itemCount: state.listChat.length,
            itemBuilder: (context, index) {
              if (state.listChat.isNotEmpty) {
                index = (state.listChat.length - 1) - index;
              }
              return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignment: state.listChat[index].id == '1' ? Alignment.centerRight : Alignment.centerLeft,
                  child: _chat(message: state.listChat[index], context: context));
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
      case 'multipleimage':
        return _listImage(message: message);
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
          style: textTitle(
              fontWeight: FontWeight.w400, size: 14, colors: id == message.id ? Colors.white : Colors.black87),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 30,
          child: Text(
            instance.get<Time>().getHourMinute(message.createAt.toString()),
            style: textTitle(colors: id == message.id ? Colors.white : AppColors.fadeText, size: 10),
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
        meBgColor: id == message.id ? AppColors.primary : const Color(0xFFBDBFBF),
      ),
      Container(
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: const Color(0xFFBDBFBF), borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        width: 30,
        child: Text(
          instance.get<Time>().getHourMinute(message.createAt.toString()),
          style: textTitle(colors: Colors.white, size: 9),
        ),
      )
    ]);
  }

  Widget _listImage({required Message message}) {
    List<String> data = message.content.split('*****');
    if (data.length == 1) {
      return _imageChat(message: message);
    }
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 0,
                children: data.map((e) {
                  print(data.length);
                  if (e.toLowerCase().endsWith('.mp4')) {
                    return Image(
                        image: const NetworkImage(
                            'https://cdn5.vectorstock.com/i/1000x1000/18/74/no-video-vector-2051874.jpg'),
                        width: MediaQuery.of(context).size.width * 0.8 / (data.length == 2 ? 2 : 3),
                        height: 200,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: Loading(
                            height: 24,
                            width: 24,
                          ));
                        });
                  }
                  return Image(
                    image: FileImage(File(e)),
                    width: MediaQuery.of(context).size.width * 0.8 / (data.length == 2 ? 2 : 3),
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                          child: Loading(
                        height: 24,
                        width: 24,
                      ));
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(color: const Color(0xFFBDBFBF), borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              width: 30,
              child: Text(
                instance.get<Time>().getHourMinute(message.createAt.toString()),
                style: textTitle(colors: Colors.white, size: 9),
              ),
            )
          ],
        ));
  }

  Widget _imageChat({required Message message}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) {
            if (message.content.toLowerCase().endsWith('.mp4')) {
              return Image(
                  image:
                      const NetworkImage('https://cdn5.vectorstock.com/i/1000x1000/18/74/no-video-vector-2051874.jpg'),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                        child: Loading(
                      height: 24,
                      width: 24,
                    ));
                  });
            }
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: FileImage(File(message.content)),
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                      child: Loading(
                    height: 24,
                    width: 24,
                  ));
                },
              ),
            );
          }),
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(color: const Color(0xFFBDBFBF), borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            width: 30,
            child: Text(
              instance.get<Time>().getHourMinute(message.createAt.toString()),
              style: textTitle(colors: Colors.white, size: 9),
            ),
          )
        ],
      ),
    );
  }
}
