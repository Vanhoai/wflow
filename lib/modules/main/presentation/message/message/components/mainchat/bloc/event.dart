

import 'dart:io';

import 'package:equatable/equatable.dart';

import 'state.dart';




sealed class MainChatEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class GetMessageEvent extends MainChatEvent{
  final dynamic chat;

  GetMessageEvent({required this.chat});
  @override
  List<Object?> get props => [chat];
}


class SendMessageEvent extends MainChatEvent{
  final Message message;

  SendMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class SendFilesEvent extends MainChatEvent{
  final String id;
  final String type;
  final File files;

  SendFilesEvent({required this.id, required this.type, required this.files});


  @override
  List<Object?> get props => [id,type,files];
}