import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/arguments_model/arguments_call.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/boxchat.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/mainchat.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/bloc.dart';
import 'components/boxchat/bloc/bloc.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  void callTapped({required bool isVideoCall, required StringeeObjectEventType callType}) {
    if (!instance.get<StringeeClient>().hasConnected) return;
    Navigator.of(context).pushNamed(
      RouteKeys.callScreen,
      arguments: ArgumentsCall(
        client: instance.get<StringeeClient>(),
        toUserId: 'teo',
        fromUserId: instance.get<StringeeClient>().userId!,
        callType: callType,
        showIncomingUi: false,
        isVideoCall: isVideoCall,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => BoxChatBloc(),
              lazy: true,
            ),
            BlocProvider(
              create: (_) => MainChatBloc(),
              lazy: true,
            ),
            BlocProvider(
              create: (_) => RecordBloc(),
              lazy: true,
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                elevation: 0.7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  AppConstants.backArrow2,
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            CircleAvatar(
                                backgroundColor: Colors.brown.shade800,
                                radius: 15,
                                backgroundImage: const NetworkImage(
                                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                'Chị HR không tuyển dụng không tuyển Huy',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              print('call');
                              callTapped(callType: StringeeObjectEventType.call2, isVideoCall: false);
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                AppConstants.phone,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                print('video call');
                                callTapped(callType: StringeeObjectEventType.call2, isVideoCall: true);
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  AppConstants.videoCall,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: InkWell(
                              onTap: () {
                                print('more');
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  AppConstants.more,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: MainChat(),
              ),
              const BoxChat(),
            ],
          ),
        ),
      ),
    );
  }
}
