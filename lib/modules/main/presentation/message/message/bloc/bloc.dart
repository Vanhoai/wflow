

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/bloc/state.dart';

class MessageBloc extends Bloc<MessageEvent,MessageState> {
  MessageBloc() : super(initState()){
    on<ShowEmojiKeyBoardEvent>(showEmojiKeyBoard);
    on<ShowRecordVoiceEvent>(showRecordVoice);
    on<SendFilesEvent>(sendFiles);
    on<SendMessageEvent>(sendMessage);
  }


  static MessageState initState(){
    return MessageState(isShowEmojiKeyboard: false, isShowRecord: false, text: "", files: []);
  }
  FutureOr<void> showEmojiKeyBoard(ShowEmojiKeyBoardEvent event, Emitter<MessageState> emit) {
      emit(state.copyWith(isShowEmojiKeyboard: event.isShow));
  }


  FutureOr<void> showRecordVoice(ShowRecordVoiceEvent event, Emitter<MessageState> emit) {
    emit(state.copyWith(isShowRecord: event.isShow));
  }



  FutureOr<void> sendFiles(SendFilesEvent event, Emitter<MessageState> emit) {

  }

  FutureOr<void> sendMessage(SendMessageEvent event, Emitter<MessageState> emit) {
  }
}

