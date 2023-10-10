import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/videocall/bloc/bloc.dart';



class VideoCallOutScreen extends StatefulWidget {
  final StringeeClient client;

  const VideoCallOutScreen({super.key, required this.client});
  @override
  State<StatefulWidget> createState() {
    return _VideoCallOutScreenState();
  }
}

class _VideoCallOutScreenState extends State<VideoCallOutScreen> {

  late final StringeeCall2 _call2 = StringeeCall2(widget.client);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_call2.id);
    _call2.eventStreamController.stream.listen((event) {
      Map<dynamic, dynamic> map = event;
      print(map['eventType']);
      switch (map['eventType']) {
        case StringeeCall2Events.didChangeSignalingState:
          handleSignalingStateChangeEvent(map['body']);
          break;
        case StringeeCall2Events.didChangeMediaState:
          handleMediaStateChangeEvent(map['body']);
          break;
        case StringeeCall2Events.didReceiveCallInfo:
          handleReceiveCallInfoEvent(map['body']);
          break;
        case StringeeCall2Events.didHandleOnAnotherDevice:
          handleHandleOnAnotherDeviceEvent(map['body']);
          break;
        case StringeeCall2Events.didReceiveLocalStream:
          handleReceiveLocalStreamEvent(map['body']);
          break;
        case StringeeCall2Events.didReceiveRemoteStream:
          handleReceiveRemoteStreamEvent(map['body']);
          break;
        case StringeeCall2Events.didAddVideoTrack:
          handleAddVideoTrackEvent(map['body']);
          break;
        case StringeeCall2Events.didRemoveVideoTrack:
          handleRemoveVideoTrackEvent(map['body']);
          break;
      /// This event only for android
        case StringeeCall2Events.didChangeAudioDevice:
          if (Platform.isAndroid) handleChangeAudioDeviceEvent(map['selectedAudioDevice'], map['availableAudioDevices']);
          break;
        default:
          break;
      }
    });
    MakeCallParams params = MakeCallParams(
      widget.client.uuid, /// caller id
       'teo', /// callee id
      isVideoCall: false, /// true - video call, false - not video call, default is 'false'
      videoQuality: VideoQuality.fullHd, /// video quality in video call, default is 'NORMAL'
    );
    _call2.makeCallFromParams(params).then((result) {
      bool status = result['status'];
      int code = result['code'];
      String message = result['message'];
      print('MakeCall CallBack --- $status - $code - $message - ${_call2.id} - from ${_call2.from} - to ${_call2.to}');
    });
  }
  /// Invoked when get Signaling state
  void handleSignalingStateChangeEvent(StringeeSignalingState state) {
    print('handleSignalingStateChangeEvent - $state');
  }

  /// Invoked when get Media state
  void handleMediaStateChangeEvent(StringeeMediaState state) {
    print('handleMediaStateChangeEvent - $state');
  }

  /// Invoked when get Call info
  void handleReceiveCallInfoEvent(Map<dynamic, dynamic> info) {
    print('handleReceiveCallInfoEvent - $info');
  }

  /// Invoked when an incoming call is handle on another device
  void handleHandleOnAnotherDeviceEvent(StringeeSignalingState state) {
    print('handleHandleOnAnotherDeviceEvent - $state');
  }

  /// Invoked when get Local stream in video call
  void handleReceiveLocalStreamEvent(String callId) {
    print('handleReceiveLocalStreamEvent - $callId');
  }

  /// Invoked when get Remote stream in video call
  void handleReceiveRemoteStreamEvent(String callId) {
    print('handleReceiveRemoteStreamEvent - $callId');
  }

  /// Invoked when add new video track to call in video call
  void handleAddVideoTrackEvent(StringeeVideoTrack track) {
    print('handleAddVideoTrackEvent - ${track.id}');
  }

  /// Invoked when remove video in call in video call
  void handleRemoveVideoTrackEvent(StringeeVideoTrack track) {
    print('handleRemoveVideoTrackEvent - ${track.id}');
  }

  /// Invoked when change Audio device in android
  void handleChangeAudioDeviceEvent(AudioDevice audioDevice, List<AudioDevice> availableAudioDevices) {
    print('handleChangeAudioDeviceEvent - $audioDevice');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}
