

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';
import 'package:permission_handler/permission_handler.dart';


class BoxChatBloc extends Bloc<BoxChatEvent,BoxChatState> {
  BoxChatBloc() : super(initState()){
    on<ShowEmojiKeyBoardEvent>(showEmojiKeyBoard);
    on<IsSendMessageTextEvent>(isSendMessageText);
    on<ShowRecordVoiceEvent>(showRecordVoice);
    on<HideAllShowEvent>(hideAllShow);
  }


  static BoxChatState initState(){
    return BoxChatState(isShowEmojiKeyboard: false, isShowVoiceRecord: false,isSend: false, text: "", files: []);
  }
  FutureOr<void> showEmojiKeyBoard(ShowEmojiKeyBoardEvent event, Emitter<BoxChatState> emit) {
      emit(state.copyWith(isShowEmojiKeyboard: !state.isShowEmojiKeyboard, isShowVoiceRecord: false));
  }

  FutureOr<void> showRecordVoice(ShowRecordVoiceEvent event, Emitter<BoxChatState> emit) async {
    final permissionRecord = await Permission.microphone.request();
    final permissionFile = await Permission.storage.request();
    if (permissionRecord != PermissionStatus.granted ||
        permissionFile != PermissionStatus.granted) {
      throw 'Chua co quyen mic';
    }

    emit(state.copyWith(isShowVoiceRecord: !state.isShowVoiceRecord, isShowEmojiKeyboard: false));
  }


  FutureOr<void> isSendMessageText(IsSendMessageTextEvent event, Emitter<BoxChatState> emit) {
    emit(state.copyWith(isSend: event.isSend.isNotEmpty));
    print(state);
  }



  FutureOr<void> hideAllShow(HideAllShowEvent event, Emitter<BoxChatState> emit) {
    emit(state.copyWith(isShowEmojiKeyboard: false, isShowVoiceRecord: false));
  }
}

