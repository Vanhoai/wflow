import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/keyboard/emoji.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';

import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';



class BoxChat extends StatefulWidget {
  const BoxChat({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BoxChatState();
  }
}

class _BoxChatState extends State<BoxChat> {
  late FlutterSoundRecorder _recordingSession;
  late String pathToAudio;
  bool isRecord = false;
  late FocusNode _focusNode;
  late TextEditingController _controller;

  Future initRecord() async {
    //pathToAudio = "${(await getTemporaryDirectory()).path}/audio/temp.wav";
    pathToAudio = '/sdcard/Download/temp.wav';
    final permissionRecord = await Permission.microphone.request();
    final permissionFile = await Permission.storage.request();
    if (permissionRecord != PermissionStatus.granted ||
        permissionFile != PermissionStatus.granted) {
      throw 'Chua co quyen mic';
    }
    _recordingSession = FlutterSoundRecorder();
    await _recordingSession.openRecorder();
    await _recordingSession
        .setSubscriptionDuration(const Duration(milliseconds: 10));
  }

  Future<void> startRecording() async {
    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );
    StreamSubscription _recorderSubscription =
        _recordingSession.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {});
    });
    _recorderSubscription.cancel();
    setState(() {
      isRecord = true;
    });
  }

  Future<String?> stopRecording() async {
    String? result = await _recordingSession.stopRecorder();
    print("Ket qua: " + result!);
    setState(() {
      isRecord = false;
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
    initRecord();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
    await _recordingSession.closeRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoxChatBloc, BoxChatState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Column(
          children: [
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
                      focusNode: _focusNode,
                      onTap: () {},
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (value) {
                        print(value);
                        _controller.clear();
                        _focusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, top: 5, right: 5, left: 5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                _showEmojiKeyBoard(context, state);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  AppConstants.smile,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            )),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset(
                                  AppConstants.clips,
                                  height: 22,
                                  width: 22,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                    AppConstants.camera,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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
                      _showRecord(context, state);
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.primary),
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
              offstage: !state.isShowRecord,
              child: Container(
                alignment: Alignment.center,
                height: 250,
                child: InkWell(
                  onTap: () {
                    if (!isRecord) {
                      startRecording();
                    } else {
                      stopRecording();
                    }
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isRecord ? Colors.red : AppColors.primary),
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      AppConstants.mic,
                      height: 20,
                      width: 20,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
            EmojiKeyboard(
              controller: _controller,
              emojiShowing: state.isShowEmojiKeyboard,
            ),
          ],
        );
      },
    );
  }

  _showEmojiKeyBoard(BuildContext context, BoxChatState state) {
    BlocProvider.of<BoxChatBloc>(context)
        .add(ShowEmojiKeyBoardEvent(isShow: !state.isShowEmojiKeyboard));
    if (state.isShowEmojiKeyboard != true) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  _showRecord(BuildContext context, BoxChatState state) {
    BlocProvider.of<BoxChatBloc>(context)
        .add(ShowRecordVoiceEvent(isShow: !state.isShowRecord));
  }
}
