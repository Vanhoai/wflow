
import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class BoxChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowEmojiKeyBoardEvent extends BoxChatEvent{
  final bool isShow;

  ShowEmojiKeyBoardEvent({required this.isShow});

  @override
  List<Object?> get props => [isShow];
}
class ShowRecordVoiceEvent extends BoxChatEvent {
  final bool isShow;

  ShowRecordVoiceEvent({required this.isShow});

  @override
  List<Object?> get props => [isShow];
}

class SendMessageEvent extends BoxChatEvent{
  final String text;

  SendMessageEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

class SendFilesEvent extends BoxChatEvent{
  final List<File> files;

  SendFilesEvent({required this.files});

  @override
  List<Object?> get props => [files];
}