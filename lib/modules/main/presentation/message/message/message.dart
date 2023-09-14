

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/keyboard/emoji.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:path/path.dart' as path;








class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  List<String> audio = [];

  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  late FlutterSoundRecorder _recordingSession;
  late String pathToAudio;
  bool emojiShowing = false;
  bool showRecord = false;
  bool isRecord = false;
  Future initRecord() async{
    //pathToAudio = "${(await getTemporaryDirectory()).path}/audio/temp.wav";
    pathToAudio = '/sdcard/Download/temp.wav';
    final permissionRecord = await Permission.microphone.request();
    final permissionFile = await Permission.storage.request();
    if(permissionRecord != PermissionStatus.granted || permissionFile != PermissionStatus.granted){
        throw 'Chua co quyen mic';
    }
    _recordingSession = FlutterSoundRecorder();
    await _recordingSession.openRecorder();
    await _recordingSession.setSubscriptionDuration(const Duration(
        milliseconds: 10));
  }

  Future<void> startRecording() async {


    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );
    StreamSubscription _recorderSubscription =
    _recordingSession.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(
          e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _controller.text = timeText.substring(0, 8);
      });
    });
    _recorderSubscription.cancel();
    setState(() {
      isRecord = true;
    });
  }
  Future<String?> stopRecording() async {

    String? result = await _recordingSession.stopRecorder();
    print("Ket qua: " + result!);
    audio.add(pathToAudio);
    setState(() {
      isRecord = false;
    });
    return result;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRecord();

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              elevation: 2,
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
              child: ListView.builder(
                  itemCount: audio.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: VoiceMessage(
                        audioSrc: audio[index],
                        //audioFile: _Record(audio[index]),
                        played: true, // To show played badge or not.
                        me: true,
                        showDuration: false,
                        formatDuration: (duration) => duration.toString().substring(2, 7),// Set message side.
                        onPlay: () {},
                        meBgColor: AppColors.primary,// Do something when voice played.
                      ),
                    );
                  },
              )
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      style: TextTitle(
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      controller: _controller,
                      maxLines: 1,
                      focusNode: focusNode,
                      onTap: () {
                        if (emojiShowing != false) {
                          setState(() {
                            emojiShowing = !emojiShowing;
                          });
                        }
                      },
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (value) {
                        print(value);
                        _controller.clear();
                        focusNode.requestFocus();
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, top: 5, right: 5, left: 5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  AppConstants.smile,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  emojiShowing = !emojiShowing;
                                  if (emojiShowing == true) {
                                    focusNode.unfocus();
                                  } else {
                                    focusNode.requestFocus();
                                  }
                                });
                              },
                            )),
                        hintText: "Nhắn tin",
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        hintStyle: TextTitle(
                            colors: AppColors.fadeText,
                            size: 14,
                            fontWeight: FontWeight.w500),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: AppColors.primary, width: 1.2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.2),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showRecord = !showRecord;
                      });
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Ink(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primary
                      ),
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppConstants.mic,
                        height: 20,
                        width: 20,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(
              height: 16,
            ),
            Offstage(
              offstage: !showRecord,
              child: Container(
                alignment: Alignment.center,
                height: 250,
                child: InkWell(
                  onTap: () {
                    if(!isRecord){
                      startRecording();
                    }else {
                      stopRecording();
                    }
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Ink(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isRecord ? Colors.red : AppColors.primary
                    ),
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      AppConstants.mic,
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
            EmojiKeyboard(
              controller: _controller,
              emojiShowing: emojiShowing,
            ),
          ],
        ),
      ),
    );
  }
}


