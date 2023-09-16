
import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';

class BoxChatState extends Equatable {
  late bool isShowEmojiKeyboard;
  late bool isShowRecord;
  final String text;
  final List<File> files;

  BoxChatState({
    required this.isShowEmojiKeyboard,
    required this.isShowRecord,
    required this.text,
    required this.files
  });
  BoxChatState copyWith({
    bool? isShowEmojiKeyboard,
    bool? isShowRecord,
    String? text,
    List<File>? files
  }) {
    return BoxChatState(
        isShowEmojiKeyboard: isShowEmojiKeyboard ?? this.isShowEmojiKeyboard,
        isShowRecord: isShowRecord ?? this.isShowRecord,
        text: text ?? this.text,
        files: files ?? this.files
    );
  }

  @override
  List<Object?> get props => [isShowEmojiKeyboard,isShowRecord,text,files];
}
