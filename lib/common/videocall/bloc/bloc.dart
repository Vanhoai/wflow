import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';

import 'event.dart';
import 'state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  final StringeeClient client;
  VideoCallBloc({required this.client}) : super(const InitVideoCallSate()) {
    on<VideoCallConnectEvent>(videoCallConnect);
    on<OnCallIncomingEvent>(onCallIncoming);
  }

  FutureOr<void> videoCallConnect(VideoCallConnectEvent event, Emitter<VideoCallState> emit) async {
    client.connect(instance.get<AppBloc>().state.authEntity.stringeeToken);
    await emit.forEach(client.eventStreamController.stream, onData: (event) {
      Map<dynamic, dynamic> map = event;
      switch (map['eventType']) {
        case StringeeClientEvents.didConnect:
          handleDidConnectEvent();
          break;
        case StringeeClientEvents.didDisconnect:
          handleDiddisconnectEvent();
          break;
        case StringeeClientEvents.didFailWithError:
          int code = map['body']['code'];
          String msg = map['body']['message'];
          handleDidFailWithErrorEvent(code, msg);
          break;
        case StringeeClientEvents.requestAccessToken:
          handleRequestAccessTokenEvent();
          break;
        case StringeeClientEvents.didReceiveCustomMessage:
          handleDidReceiveCustomMessageEvent(map['body']);
          break;
        case StringeeClientEvents.incomingCall:
          StringeeCall call = map['body'];
          handleIncomingCallEvent(call);
          break;
        case StringeeClientEvents.incomingCall2:
          StringeeCall2 call = map['body'];
          handleIncomingCall2Event(call);
          break;
        default:
          break;
      }
      return const CallVideoConnect();
    });
  }

  /// Invoked when the StringeeClient is connected
  void handleDidConnectEvent() {
    print('connect stringee');
  }

  /// Invoked when the StringeeClient is disconnected
  void handleDiddisconnectEvent() {
    print('disconnect stringee');
  }

  /// Invoked when StringeeClient connect false
  void handleDidFailWithErrorEvent(int code, String message) {
    print('error$message');
  }

  /// Invoked when your token is expired
  void handleRequestAccessTokenEvent() {}

  /// Invoked when get Custom message
  void handleDidReceiveCustomMessageEvent(Map<dynamic, dynamic> map) {}

  /// Invoked when receive an incoming of StringeeCall
  void handleIncomingCallEvent(StringeeCall call) {}

  /// Invoked when receive an incoming of StringeeCall2
  void handleIncomingCall2Event(StringeeCall2 call) {
    print('cuoc goi toi${call.from}');
    print(call.id);
    add(OnCallIncomingEvent(call: call));
  }

  FutureOr<void> onCallIncoming(OnCallIncomingEvent event, Emitter<VideoCallState> emit) {
    emit(CallInComing(call: event.call));
  }
}
