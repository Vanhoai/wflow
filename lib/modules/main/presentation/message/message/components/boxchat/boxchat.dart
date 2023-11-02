import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/arguments_model/arguments_photo.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/keyboard/emoji.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/record.dart';

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
  late FocusNode _focusNode;
  late TextEditingController _controller;
  late File file;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _controller.addListener(() {
      context.read<BoxChatBloc>().add(IsSendMessageTextEvent(_controller.text));
    });
    _focusNode = FocusNode();
  }

  @override
  void dispose() async {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoxChatBloc, BoxChatState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      minLines: 1,
                      maxLines: 5,
                      // and this
                      controller: _controller,
                      focusNode: _focusNode,
                      onTap: () {
                        context.read<BoxChatBloc>().add(HideAllShowEvent());
                        context.read<MainChatBloc>().add(ScrollEvent());
                      },
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 5, top: 5, right: 5, left: 5),
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
                                _getImage();
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
                                onTap: () {},
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
                        hintText: 'Nhắn tin',
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black26),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.primary, width: 1.2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.black26, width: 1.2),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 5),
                  child: InkWell(
                    onTap: () {
                      if (!state.isSend) {
                        _showRecord(context, state);
                      } else {
                        _sendMessage(
                            context,
                            Message(
                              id: '1',
                              content: _controller.text,
                              type: 'text',
                            ));
                        _controller.clear();
                        if (!state.isShowEmojiKeyboard && !state.isShowVoiceRecord) {
                          _focusNode.requestFocus();
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Ink(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.primary),
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        state.isSend ? AppConstants.send : AppConstants.mic,
                        height: 20,
                        width: 20,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
              offstage: !state.isShowVoiceRecord,
              child: const Record(),
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
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    BlocProvider.of<BoxChatBloc>(context).add(ShowEmojiKeyBoardEvent());
    if (state.isShowEmojiKeyboard != true) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  _showRecord(BuildContext context, BoxChatState state) {
    BlocProvider.of<BoxChatBloc>(context).add(ShowRecordVoiceEvent());
    if (state.isShowVoiceRecord != true) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  _sendMessage(BuildContext context, Message message) {
    BlocProvider.of<MainChatBloc>(context).add(SendMessageEvent(message: message));
  }

  Future<void> _getImage() async {
    var result = await Navigator.of(context)
        .pushNamed(RouteKeys.photoScreen, arguments: ArgumentsPhoto(multiple: true, onlyImage: false));
    result as List<File>;
    if (context.mounted) {
      BlocProvider.of<MainChatBloc>(context).add(SendFilesEvent(id: '', type: 'type', files: result));
    }
  }
}
