
import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';

class MessageState extends Equatable {
  late  bool isShowEmojiKeyboard;
  late bool isShowRecord;
  final String text;
  final List<File> files;

  MessageState({
    required this.isShowEmojiKeyboard,
    required this.isShowRecord,
    required this.text,
    required this.files
  });
  MessageState copyWith({
    bool? isShowEmojiKeyboard,
    bool? isShowRecord,
    String? text,
    List<File>? files
  }) {
    return MessageState(
        isShowEmojiKeyboard: isShowEmojiKeyboard ?? this.isShowEmojiKeyboard,
        isShowRecord: isShowRecord ?? this.isShowRecord,
        text: text ?? this.text,
        files: files ?? this.files
    );
  }

  @override
  List<Object?> get props => [isShowEmojiKeyboard,isShowRecord,text,files];
}
