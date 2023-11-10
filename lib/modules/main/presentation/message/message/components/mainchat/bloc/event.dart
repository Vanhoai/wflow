import 'dart:io';
import 'package:equatable/equatable.dart';

sealed class MainChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetListMessage extends MainChatEvent {
  GetListMessage();
  @override
  List<Object?> get props => [];
}

class GetListMessageMore extends MainChatEvent {
  GetListMessageMore();
  @override
  List<Object?> get props => [];
}

class GetMessageEvent extends MainChatEvent {
  final dynamic chat;

  GetMessageEvent({required this.chat});
  @override
  List<Object?> get props => [chat];
}

class SendMessageEvent extends MainChatEvent {
  final String message;
  final String type;
  SendMessageEvent({required this.message, required this.type});

  @override
  List<Object?> get props => [message];
}

class JoinRoomEvent extends MainChatEvent {
  final dynamic roomID;
  JoinRoomEvent({required this.roomID});

  @override
  List<Object?> get props => [roomID];
}

class SendFilesEvent extends MainChatEvent {
  final String id;
  final String type;
  final List<File> files;

  SendFilesEvent({required this.id, required this.type, required this.files});

  @override
  List<Object?> get props => [id, type, files];
}

class SendRecordEvent extends MainChatEvent {
  final File file;

  SendRecordEvent({required this.file});
  @override
  List<Object?> get props => [file];
}

class ScrollEvent extends MainChatEvent {
  ScrollEvent();
}
