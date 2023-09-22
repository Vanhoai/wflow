
import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';

class BoxChatState extends Equatable {
  late bool isShowEmojiKeyboard;
  late bool isSend;
  final String text;
  final List<File> files;

  BoxChatState({
    required this.isShowEmojiKeyboard,
    required this.isSend,
    required this.text,
    required this.files,
  });
  BoxChatState copyWith({
    bool? isShowEmojiKeyboard,
    bool? isShowRecord,
    bool? isSend,
    String? text,
    List<File>? files
  }) {
    return BoxChatState(
        isShowEmojiKeyboard: isShowEmojiKeyboard ?? this.isShowEmojiKeyboard,
        isSend: isSend ?? this.isSend,
        text: text ?? this.text,
        files: files ?? this.files
    );
  }

  @override
  List<Object?> get props => [isShowEmojiKeyboard,text,isSend,files];
}
