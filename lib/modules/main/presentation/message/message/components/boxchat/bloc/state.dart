
import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';

class BoxChatState extends Equatable {
  late bool isShowEmojiKeyboard;
  late bool isShowVoiceRecord;
  late bool isSend;
  final List<File> files;

  BoxChatState({
    required this.isShowEmojiKeyboard,
    required this.isShowVoiceRecord,
    required this.isSend,
    required this.files,
  });
  BoxChatState copyWith({
    bool? isShowEmojiKeyboard,
    bool? isShowVoiceRecord,
    bool? isShowRecord,
    bool? isSend,
    String? text,
    List<File>? files
  }) {
    return BoxChatState(
        isShowEmojiKeyboard: isShowEmojiKeyboard ?? this.isShowEmojiKeyboard,
        isShowVoiceRecord: isShowVoiceRecord ?? this.isShowVoiceRecord,
        isSend: isSend ?? this.isSend,
        files: files ?? this.files
    );
  }

  @override
  List<Object?> get props => [isShowEmojiKeyboard,isShowVoiceRecord,isSend,files];
}
