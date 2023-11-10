import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/meta/meta_model.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';

//De tam

class MainChatState extends Equatable {
  final List<MessagesEntity> listChat;
  final bool scroll;
  final Meta meta;
  final String search;
  final File? file;
  final double percent;
  const MainChatState(
      {required this.listChat,
      this.scroll = false,
      this.meta = const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
      this.file,
      this.percent = 0,
      this.search = ''});

  MainChatState copyWith(
      {List<MessagesEntity>? listChat, bool? scroll, Meta? meta, String? search, File? file, double? percent}) {
    return MainChatState(
        listChat: listChat ?? this.listChat,
        scroll: scroll ?? this.scroll,
        meta: meta ?? this.meta,
        file: file,
        percent: percent ?? this.percent,
        search: search ?? this.search);
  }

  @override
  List<Object?> get props => [scroll, listChat, meta, search, file, percent];
}

class Scroll extends MainChatState {
  const Scroll(
      {required super.listChat,
      required super.file,
      required super.scroll,
      required super.meta,
      required super.percent,
      required super.search});

  @override
  List<Object?> get props => [scroll, listChat, meta, search, file, percent];
}
