

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';


class BoxChatBloc extends Bloc<BoxChatEvent,BoxChatState> {
  BoxChatBloc() : super(initState()){
    on<ShowEmojiKeyBoardEvent>(showEmojiKeyBoard);
    on<ShowRecordVoiceEvent>(showRecordVoice);
    on<SendFilesEvent>(sendFiles);
    on<SendMessageEvent>(sendMessage);
  }


  static BoxChatState initState(){
    return BoxChatState(isShowEmojiKeyboard: false, isShowRecord: false, text: "", files: []);
  }
  FutureOr<void> showEmojiKeyBoard(ShowEmojiKeyBoardEvent event, Emitter<BoxChatState> emit) {
      emit(state.copyWith(isShowEmojiKeyboard: event.isShow));
  }


  FutureOr<void> showRecordVoice(ShowRecordVoiceEvent event, Emitter<BoxChatState> emit) {
    emit(state.copyWith(isShowRecord: event.isShow));
  }



  FutureOr<void> sendFiles(SendFilesEvent event, Emitter<BoxChatState> emit) {

  }

  FutureOr<void> sendMessage(SendMessageEvent event, Emitter<BoxChatState> emit) {
  }
}

