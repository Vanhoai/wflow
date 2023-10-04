



import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/presentation/videocall/bloc/event.dart';
import 'package:wflow/modules/main/presentation/videocall/bloc/state.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
class VideoCallBloc extends Bloc<VideoCallEvent,VideoCallState>{
  final StringeeClient _client = StringeeClient();
  String token = 'eyJjdHkiOiJzdHJpbmdlZS1hcGk7dj0xIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJqdGkiOiJTSy4wLlJZUkhkRWhKQVFMcFhTODlvcjFOQjBDblFraUl5LTE2OTYyNTI5MTYiLCJpc3MiOiJTSy4wLlJZUkhkRWhKQVFMcFhTODlvcjFOQjBDblFraUl5IiwiZXhwIjoxNjk4ODQ0OTE2LCJ1c2VySWQiOiJoeXV5In0.767Xb9ea-r4vTSnxg4Yu91swzaVxrDBGbaG3vY1YlqY';

  VideoCallBloc() : super(const InitVideoCallSate()){
    on<VideoCallConnectEvent>(videoCallConnect);
  }

  FutureOr<void> videoCallConnect(VideoCallConnectEvent event, Emitter<VideoCallState> emit) async {
    _client.connect(token);
    await emit.forEach(_client.eventStreamController.stream, onData: (event){
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
          handleDidFailWithErrorEvent(code,msg);
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
    print("connect stringee");
  }

  /// Invoked when the StringeeClient is disconnected
  void handleDiddisconnectEvent() {
    print("disconnect stringee");
  }

  /// Invoked when StringeeClient connect false
  void handleDidFailWithErrorEvent(int code, String message) {
    print("error" + message);
  }

  /// Invoked when your token is expired
  void handleRequestAccessTokenEvent() {}

  /// Invoked when get Custom message
  void handleDidReceiveCustomMessageEvent(Map<dynamic, dynamic> map) {}

  /// Invoked when receive an incoming of StringeeCall
  void handleIncomingCallEvent(StringeeCall call) {

  }

  /// Invoked when receive an incoming of StringeeCall2
  void handleIncomingCall2Event(StringeeCall2 call) {
  }


}