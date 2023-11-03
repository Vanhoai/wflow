import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';
import 'package:permission_handler/permission_handler.dart';

class BoxChatBloc extends Bloc<BoxChatEvent, BoxChatState> {
  BoxChatBloc() : super(initState()) {
    on<ShowEmojiKeyBoardEvent>(showEmojiKeyBoard);
    on<IsSendMessageTextEvent>(isSendMessageText);
    on<ShowRecordVoiceEvent>(showRecordVoice);
    on<HideAllShowEvent>(hideAllShow);
  }

  static BoxChatState initState() {
    return const BoxChatState(isShowEmojiKeyboard: false, isShowVoiceRecord: false, isSend: false, files: []);
  }

  FutureOr<void> showEmojiKeyBoard(ShowEmojiKeyBoardEvent event, Emitter<BoxChatState> emit) {
    emit(state.copyWith(isShowEmojiKeyboard: !state.isShowEmojiKeyboard, isShowVoiceRecord: false));
  }

  FutureOr<void> showRecordVoice(ShowRecordVoiceEvent event, Emitter<BoxChatState> emit) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfoPlugin.androidInfo.then((value) async {
      if (value.version.sdkInt >= 31) {
        Map<Permission, PermissionStatus> statuses =
            await [Permission.microphone, Permission.bluetoothConnect, Permission.storage].request();
        print(statuses);
      } else {
        Map<Permission, PermissionStatus> statuses = await [Permission.microphone, Permission.storage].request();
        print(statuses);
      }
    });

    emit(state.copyWith(isShowVoiceRecord: !state.isShowVoiceRecord, isShowEmojiKeyboard: false));
  }

  FutureOr<void> isSendMessageText(IsSendMessageTextEvent event, Emitter<BoxChatState> emit) {
    emit(state.copyWith(isSend: event.isSend.isNotEmpty));
  }

  FutureOr<void> hideAllShow(HideAllShowEvent event, Emitter<BoxChatState> emit) {
    emit(state.copyWith(isShowEmojiKeyboard: false, isShowVoiceRecord: false));
  }
}
