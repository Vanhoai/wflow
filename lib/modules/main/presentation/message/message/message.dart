import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/videocall/bloc/bloc.dart';
import 'package:wflow/common/videocall/bloc/event.dart';
import 'package:wflow/common/videocall/bloc/state.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/main/presentation/message/message/components/boxchat/boxchat.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/mainchat.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/bloc.dart';

import '../videocall/call.dart';
import 'components/boxchat/bloc/bloc.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
  }

  requestPermissions() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfoPlugin.androidInfo.then((value) async {
      if (value.version.sdkInt >= 31) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.microphone,
          Permission.bluetoothConnect,
        ].request();
        print(statuses);
      } else {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.microphone,
        ].request();
        print(statuses);
      }
    });
  }
  void call(StringeeCall2 call) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Call(
          instance.get<StringeeClient>(),
          call.from!,
          call.to!,
          true,
          call.isVideoCall,
          StringeeObjectEventType.call2,
          stringeeCall2: call,
        ),
      ),
    );
  }
  void callTapped({required bool isVideoCall, required StringeeObjectEventType callType}) {
    if (!instance.get<StringeeClient>().hasConnected) return;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Call(
            instance.get<StringeeClient>(),
            instance.get<StringeeClient>().userId!,
            'teo',
            false,
            isVideoCall,
            callType,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.light,
    ));
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
          child: BlocListener(
            listener: (context, state) {
              if(state is CallInComing)
              {
                call(state.call);
              }
            },
            bloc: instance.get<VideoCallBloc>()..add(const VideoCallConnectEvent()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 0.7,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                                  "Chị HR không tuyển dụng không tuyển Huy",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextTitle(
                                      fontWeight: FontWeight.w700, size: 14),
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
                                print("call");
                                callTapped(callType: StringeeObjectEventType.call2,isVideoCall: false);

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
                                  print("video call");
                                  callTapped(callType: StringeeObjectEventType.call2,isVideoCall: true);
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
                                  print("more");
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
      ),
    );
  }
}
