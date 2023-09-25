
import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class BoxChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowEmojiKeyBoardEvent extends BoxChatEvent{

  ShowEmojiKeyBoardEvent();

  @override
  List<Object?> get props => [];
}

class ShowRecordVoiceEvent extends BoxChatEvent {

  ShowRecordVoiceEvent();

  @override
  List<Object?> get props => [];
}

class HideAllShowEvent extends BoxChatEvent{
  HideAllShowEvent();

}

class IsSendMessageTextEvent extends BoxChatEvent{
  final String isSend;

  IsSendMessageTextEvent(this.isSend);

  @override
  List<Object?> get props => [isSend];
}