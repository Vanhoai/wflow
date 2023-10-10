


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/videocall/bloc/bloc.dart';

class VideoCallInScreen extends StatefulWidget{
  final StringeeCall2? call2;

   const VideoCallInScreen({super.key, this.call2});

  @override
  State<StatefulWidget> createState() => _VideoCallInScreenState();

}

class _VideoCallInScreenState extends State<VideoCallInScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.call2?.eventStreamController.stream.listen((event) {
      Map<dynamic, dynamic> map = event;
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

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  widget.call2?.answer().then((event) {
                    bool status = event['status'];
                    if (status) {
                      print(status);
                    }else{
                      print(status);
                    }
                  });
                },
                child: Text("tra loi")),
            ElevatedButton(
                onPressed: () {
                  widget.call2?.reject().then((event) {
                    bool status = event['status'];
                    if (status) {
                      print(status);
                    }else{
                      print(status);
                    }
                  });
                },
                child: Text("Cup may"))
          ],
        ),
      ),
    );
  }

}