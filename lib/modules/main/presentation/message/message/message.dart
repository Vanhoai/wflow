

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

import 'package:wflow/core/widgets/style/textfieldstyle.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => BoxChatBloc(),
              lazy: true,
            ),
            BlocProvider(
              create: (_) => MainChatBloc(),
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
                              print("Call");
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
              Expanded(
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


