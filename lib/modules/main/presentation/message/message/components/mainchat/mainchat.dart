import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/custom/circular_percent/circular_percent.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';

class MainChat extends StatefulWidget {
  const MainChat({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainChatState();
  }
}

class _MainChatState extends State<MainChat> {
  final num id = instance.get<AppBloc>().state.userEntity.id;

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
        scrollController.addListener(() {
          if (state.meta.currentPage >= state.meta.totalPage) return;
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            context.read<MainChatBloc>().add(GetListMessageMore());
          }
        });
        return Stack(
          children: [
            Listener(
              onPointerDown: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<BoxChatBloc>().add(HideAllShowEvent());
              },
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                cacheExtent: 99999,
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                itemCount: state.listChat.length,
                itemBuilder: (context, index) {
                  if (state.listChat.isNotEmpty) {
                    //index = (state.listChat.length - 1) - index;
                  }
                  return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      alignment:
                          state.listChat[index].userSender.id == id ? Alignment.centerRight : Alignment.centerLeft,
                      child: _chat(message: state.listChat[index], context: context));
                },
              ),
            ),
            Visibility(
              visible: state.file != null,
              child: Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircularPercentIndicator(
                        animation: true,
                        radius: 24,
                        percent: state.percent,
                        center: Text(
                          '${(state.percent * 100).toStringAsFixed(0)}%',
                        ),
                        progressColor: AppColors.primary,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        state.file != null ? state.file!.path.toString() : '',
                        style: themeData.textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  Widget _chat({required MessagesEntity message, required BuildContext context}) {
    switch (message.type.toLowerCase()) {
      case 'text':
        return _textChat(message: message, context: context);
      case 'record':
        return _voiceChat(message: message);
      case 'image':
        return _listImage(message: message);
      default:
        return _textChat(message: message, context: context);
    }
  }

  Widget _textChat({required MessagesEntity message, required BuildContext context}) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: id == message.userSender.id ? AppColors.primary : AppColors.fade,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          message.message,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: id == message.userSender.id ? Colors.white : Colors.black),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 50,
          child: Text(
            instance.get<Time>().getHourMinute(message.createdAt.toString()),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: id == message.userSender.id ? Colors.white : Colors.black54, fontSize: 9),
          ),
        )
      ]),
    );
  }

  Widget _voiceChat({required MessagesEntity message}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      VoiceMessage(
        audioSrc: message.message,
        played: true,
        // To show played badge or not.
        me: true,
        showDuration: false,
        formatDuration: (duration) => duration.toString().substring(2, 7),
        // Set message side.
        meBgColor: id == message.userSender.id ? AppColors.primary : const Color(0xFFBDBFBF),
      ),
      Container(
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: const Color(0xFFBDBFBF), borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        width: 50,
        child: Text(
          instance.get<Time>().getHourMinute(message.createdAt.toString()),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 9),
        ),
      )
    ]);
  }

  Widget _listImage({required MessagesEntity message}) {
    List<String> data = message.message.split('*****');
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
                  if (e.toLowerCase().endsWith('.mp4')) {
                    return Image(
                      image: const NetworkImage(
                          'https://cdn5.vectorstock.com/i/1000x1000/18/74/no-video-vector-2051874.jpg'),
                      width: MediaQuery.of(context).size.width * 0.8 / (data.length == 2 ? 2 : 3),
                      height: 200,
                      fit: BoxFit.cover,
                    );
                  }
                  return CachedNetworkImage(
                    imageUrl: e,
                    width: MediaQuery.of(context).size.width * 0.8 / (data.length == 2 ? 2 : 3),
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                        child: Loading(
                      height: 24,
                      width: 24,
                    )),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(color: const Color(0xFFBDBFBF), borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              width: 50,
              child: Text(
                instance.get<Time>().getHourMinute(message.createdAt.toString()),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 9),
              ),
            )
          ],
        ));
  }

  Widget _imageChat({required MessagesEntity message}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) {
            if (message.message.toLowerCase().endsWith('.mp4')) {
              return const Image(
                image: NetworkImage('https://cdn5.vectorstock.com/i/1000x1000/18/74/no-video-vector-2051874.jpg'),
                fit: BoxFit.cover,
              );
            }
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: message.message,
                placeholder: (context, url) => const Center(
                    child: Loading(
                  height: 24,
                  width: 24,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            );
          }),
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(color: const Color(0xFFBDBFBF), borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            width: 50,
            child: Text(
              instance.get<Time>().getHourMinute(message.createdAt.toString()),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 9),
            ),
          )
        ],
      ),
    );
  }
}
