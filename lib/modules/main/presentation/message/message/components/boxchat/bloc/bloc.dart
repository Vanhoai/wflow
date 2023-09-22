

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';


class BoxChatBloc extends Bloc<BoxChatEvent,BoxChatState> {
  BoxChatBloc() : super(initState()){
    on<ShowEmojiKeyBoardEvent>(showEmojiKeyBoard);
    on<IsSendMessageTextEvent>(isSendMessageText);
  }


  static BoxChatState initState(){
    return BoxChatState(isShowEmojiKeyboard: false, isSend: false, text: "", files: []);
  }
  FutureOr<void> showEmojiKeyBoard(ShowEmojiKeyBoardEvent event, Emitter<BoxChatState> emit) {
      emit(state.copyWith(isShowEmojiKeyboard: event.isShow));
  }




  FutureOr<void> isSendMessageText(IsSendMessageTextEvent event, Emitter<BoxChatState> emit) {
    emit(state.copyWith(isSend: event.isSend.isNotEmpty));
    print(state);
  }
}

