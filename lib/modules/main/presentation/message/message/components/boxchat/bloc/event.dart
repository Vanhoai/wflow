
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


class IsSendMessageTextEvent extends BoxChatEvent{
  final String isSend;

  IsSendMessageTextEvent(this.isSend);

  @override
  List<Object?> get props => [isSend];
}