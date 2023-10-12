import 'dart:io';

import 'package:equatable/equatable.dart';

class BoxChatState extends Equatable {
  final bool isShowEmojiKeyboard;
  final bool isShowVoiceRecord;
  final bool isSend;
  final List<File> files;

  const BoxChatState({
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
    List<File>? files,
  }) {
    return BoxChatState(
      isShowEmojiKeyboard: isShowEmojiKeyboard ?? this.isShowEmojiKeyboard,
      isShowVoiceRecord: isShowVoiceRecord ?? this.isShowVoiceRecord,
      isSend: isSend ?? this.isSend,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props => [isShowEmojiKeyboard, isShowVoiceRecord, isSend, files];
}
