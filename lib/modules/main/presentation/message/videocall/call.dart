import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/button/circle_button.dart';

class Call extends StatefulWidget {
  late StringeeClient _client;
  late StringeeCall2? _stringeeCall2;
  late String _toUserId;
  late String _fromUserId;
  late StringeeObjectEventType _callType;
  bool _showIncomingUi = false;
  bool _isVideoCall = false;

  Call(
    StringeeClient client,
    String fromUserId,
    String toUserId,
    bool showIncomingUi,
    bool isVideoCall,
    StringeeObjectEventType callType, {
    Key? key,
    StringeeCall2? stringeeCall2,
    StringeeCall? stringeeCall,
  }) : super(key: key) {
    _client = client;
    _fromUserId = fromUserId;
    _toUserId = toUserId;
    _showIncomingUi = showIncomingUi;
    _isVideoCall = isVideoCall;
    _callType = callType;
    if (stringeeCall2 != null) {
      _stringeeCall2 = stringeeCall2;
    }

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CallState();
  }
}

class _CallState extends State<Call> {
  String status = '';
  bool _isSpeaker = false;
  bool _isMute = false;
  bool _isVideoEnable = false;

  Widget? localScreen;
  Widget? remoteScreen;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isSpeaker = widget._isVideoCall;
    _isVideoEnable = widget._isVideoCall;

    if (widget._callType == StringeeObjectEventType.call2) {
      makeOrInitAnswerCall2();
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget nameCalling =  Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 120.0),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 15.0),
            child:  Text(
              (widget._showIncomingUi ?
              widget._fromUserId : widget._toUserId),
              style:  const TextStyle(
                color: Colors.white,
                fontSize: 35.0,
              ),
            ),
          ),
           Container(
            alignment: Alignment.center,
            child: Text(
              status,
              style:  const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          )
        ],
      ),
    );

    Widget btnSwitch = widget._isVideoCall ? Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 25.0),
        child: CircleButton(
            icon: const Icon(
              Icons.switch_camera,
              color: Colors.white,
              size: 28,
            ),
            primary: Colors.transparent,
            onPressed: toggleSwitchCamera),
      ),
    ): const SizedBox();

    Container bottomContainer = Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      alignment: Alignment.bottomCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget._showIncomingUi
              ? <Widget>[
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleButton(
                          icon: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 28,
                          ),
                          primary: Colors.red,
                          onPressed: rejectCallTapped),
                      CircleButton(
                          icon: const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 28,
                          ),
                          primary: Colors.green,
                          onPressed: acceptCallTapped),
                    ],
                  )
                ]
              : <Widget>[
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleButton(
                          icon: _isSpeaker
                              ? const Icon(
                                  Icons.volume_off,
                                  color: Colors.black,
                                  size: 28,
                                )
                              : const Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 28,
                                ),
                          primary: _isSpeaker ? Colors.white : Colors.white54,
                          onPressed: toggleSpeaker),
                      CircleButton(
                          icon: _isMute
                              ? const Icon(
                                  Icons.mic,
                                  color: Colors.black,
                                  size: 28,
                                )
                              : const Icon(
                                  Icons.mic_off,
                                  color: Colors.white,
                                  size: 28,
                                ),
                          primary: _isMute ? Colors.white : Colors.white54,
                          onPressed: toggleMicro),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return widget._isVideoCall ?  CircleButton(
                              icon: _isVideoEnable
                                  ? const Icon(
                                Icons.videocam_off,
                                color: Colors.white,
                                size: 28,
                              )
                                  : const Icon(
                                Icons.videocam,
                                color: Colors.black,
                                size: 28,
                              ),
                              primary:
                              _isVideoEnable ? Colors.white54 : Colors.white,
                              onPressed: toggleVideo) : const SizedBox();
                        },
                      ),
                      CircleButton(
                          icon: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 28,
                          ),
                          primary: Colors.red,
                          onPressed: endCallTapped),
                    ],
                  ),
                ]),
    );

    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body:  Stack(
            children: <Widget>[
              remoteScreen != null
                  ? remoteScreen!
                  : Image.asset(
                  AppConstants.backgroudVideoCall,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill),
              localScreen != null
                  ? localScreen!
                  : Image.asset(
                  AppConstants.backgroudVideoCall,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill),
              nameCalling,
              bottomContainer,
              btnSwitch,
            ],
          ),
        ),
      ),
      onWillPop: () {
        endCallTapped();
        return Future.value(false);
      },
    );
  }


  Future makeOrInitAnswerCall2() async {
    if (!widget._showIncomingUi) {
      widget._stringeeCall2 = StringeeCall2(widget._client);
    }

    // Listen events
    widget._stringeeCall2!.eventStreamController.stream.listen((event) {
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
        case StringeeCall2Events.didChangeAudioDevice:
          if (Platform.isAndroid) {
            handleChangeAudioDeviceEvent(map['selectedAudioDevice']);
          }
          break;
        default:
          break;
      }
    });

    if (widget._showIncomingUi) {
      widget._stringeeCall2!.initAnswer().then((event) {
        bool status = event['status'];
        if (!status) {
          clearDataEndDismiss();
        }
      });
    } else {
      final parameters = {
        'from': widget._fromUserId,
        'to': widget._toUserId,
        'isVideoCall': widget._isVideoCall,
        'customData': null,
        'videoQuality': VideoQuality.fullHd,
      };

      widget._stringeeCall2!.makeCall(parameters).then((result) {
        bool status = result['status'];
        int code = result['code'];
        String message = result['message'];
        print(
            'MakeCall CallBack --- $status - $code - $message - ${widget._stringeeCall2!.id} - ${widget._stringeeCall2!.from} - ${widget._stringeeCall2!.to}');
        if (!status) {
          Navigator.pop(context);
        }
      });
    }
  }

  void endCallTapped() {
     if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.hangup().then((result) {
        print('_endCallTapped -- ${result['message']}');
        bool status = result['status'];
        if (status) {
          if (Platform.isAndroid) {
            clearDataEndDismiss();
          }
        }
      });
    }
  }

  void acceptCallTapped() {
     if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.answer().then((result) {
        print('_acceptCallTapped -- ${result['message']}');
        bool status = result['status'];
        if (!status) {
          clearDataEndDismiss();
        }
      });
    }
    setState(() {
      widget._showIncomingUi = !widget._showIncomingUi;
    });
  }

  void rejectCallTapped() {
    if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.reject().then((result) {
        print('_rejectCallTapped -- ${result['message']}');
        if (Platform.isAndroid) {
          clearDataEndDismiss();
        }
      });
    }
  }

  void handleSignalingStateChangeEvent(StringeeSignalingState state) {
    print('handleSignalingStateChangeEvent - $state');
    setState(() {
      status = state.toString().split('.')[1];
    });
    switch (state) {
      case StringeeSignalingState.calling:
        break;
      case StringeeSignalingState.ringing:
        break;
      case StringeeSignalingState.answered:
        break;
      case StringeeSignalingState.busy:
        clearDataEndDismiss();
        break;
      case StringeeSignalingState.ended:
        clearDataEndDismiss();
        break;
      default:
        break;
    }
  }

  void handleMediaStateChangeEvent(StringeeMediaState state) {
    print('handleMediaStateChangeEvent - $state');
    setState(() {
      status = state.toString().split('.')[1];
    });
    switch (state) {
      case StringeeMediaState.connected:
        if (widget._callType == StringeeObjectEventType.call2) {
          widget._stringeeCall2!.setSpeakerphoneOn(_isSpeaker);
        }
        break;
      case StringeeMediaState.disconnected:
        break;
      default:
        break;
    }
  }

  void handleReceiveCallInfoEvent(Map<dynamic, dynamic> info) {
    print('handleReceiveCallInfoEvent - $info');
  }

  void handleHandleOnAnotherDeviceEvent(StringeeSignalingState state) {
    print('handleHandleOnAnotherDeviceEvent - $state');
    if (state == StringeeSignalingState.answered ||
        state == StringeeSignalingState.ended ||
        state == StringeeSignalingState.busy) {
      clearDataEndDismiss();
    }
  }

  void handleReceiveLocalStreamEvent(String callId) {
    print('handleReceiveLocalStreamEvent - $callId');
    if (localScreen != null) {
      setState(() {
        localScreen = null;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          localScreen =  StringeeVideoView(
            callId,
            true,
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(bottom: 100.0, right: 25.0),
            height: 150.0,
            width: 100.0,
            borderRadius: BorderRadius.circular(8),
            scalingType: ScalingType.fill,
            isMirror: true,

          );
        });
      });
    } else {
      setState(() {
        localScreen =  StringeeVideoView(
          callId,
          true,
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(bottom: 130.0, right: 25.0),
          height: 150.0,
          width: 100.0,
          borderRadius: BorderRadius.circular(8),
          scalingType: ScalingType.fill,
          isMirror: true,
        );
      });
    }
  }

  void handleReceiveRemoteStreamEvent(String callId) {
    print('handleReceiveRemoteStreamEvent - $callId');
    if (remoteScreen != null) {
      setState(() {
        remoteScreen = null;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          remoteScreen =  StringeeVideoView(
            callId,
            false,
            isMirror: false,
            scalingType: ScalingType.fill,
          );
        });
      });
    } else {
      setState(() {
        remoteScreen =  StringeeVideoView(
          callId,
          false,
          isMirror: false,
          scalingType: ScalingType.fill,
        );
      });
    }
  }

  void handleAddVideoTrackEvent(StringeeVideoTrack track) {
    print('handleAddVideoTrackEvent - ${track.id}');
    if (track.isLocal) {
      setState(() {
        localScreen = null;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          localScreen = track.attach(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 25.0, right: 25.0),
            height: 150.0,
            width: 100.0,
            scalingType: ScalingType.fit,
          );
        });
      });
    } else {
      setState(() {
        remoteScreen = null;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          remoteScreen = track.attach(
            isMirror: false,
            scalingType: ScalingType.fit,
          );
        });
      });
    }
  }

  void handleRemoveVideoTrackEvent(StringeeVideoTrack track) {
    print('handleRemoveVideoTrackEvent - ${track.id}');
  }

  void handleChangeAudioDeviceEvent(AudioDevice audioDevice) {
    print('handleChangeAudioDeviceEvent - $audioDevice');
    switch (audioDevice) {
      case AudioDevice.speakerPhone:
      case AudioDevice.earpiece:
        if (widget._callType == StringeeObjectEventType.call2) {
          widget._stringeeCall2!.setSpeakerphoneOn(_isSpeaker);
        }
        break;
      case AudioDevice.bluetooth:
      case AudioDevice.wiredHeadset:
        setState(() {
          _isSpeaker = false;
        });
         if (widget._callType == StringeeObjectEventType.call2) {
          widget._stringeeCall2!.setSpeakerphoneOn(_isSpeaker);
        }
        break;
      case AudioDevice.none:
        print('handleChangeAudioDeviceEvent - non audio devices connected');
        break;
    }
  }

  void clearDataEndDismiss() {
     if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.destroy();
      widget._stringeeCall2 = null;
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  void toggleSwitchCamera() {
     if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.switchCamera().then((result) {
        bool status = result['status'];
        if (status) {}
      });
    }
  }

  void toggleSpeaker() {
    if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.setSpeakerphoneOn(!_isSpeaker).then((result) {
        bool status = result['status'];
        if (status) {
          setState(() {
            _isSpeaker = !_isSpeaker;
          });
        }
      });
    }
  }

  void toggleMicro() {
    if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.mute(!_isMute).then((result) {
        bool status = result['status'];
        if (status) {
          setState(() {
            _isMute = !_isMute;
          });
        }
      });
    }
  }

  void toggleVideo() {
     if (widget._callType == StringeeObjectEventType.call2) {
      widget._stringeeCall2!.enableVideo(!_isVideoEnable).then((result) {
        bool status = result['status'];
        if (status) {
          setState(() {
            _isVideoEnable = !_isVideoEnable;
          });
        }
      });
    }
  }

  // void createForegroundServiceNotification() {
  //   flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
  //     android: AndroidInitializationSettings('ic_launcher'),
  //   ));
  //
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.startForegroundService(
  //         1,
  //         'Screen capture',
  //         'Capturing',
  //         notificationDetails: const AndroidNotificationDetails(
  //           'Test id',
  //           'Test name',
  //           channelDescription: 'Test description',
  //           importance: Importance.defaultImportance,
  //           priority: Priority.defaultPriority,
  //         ),
  //       );
  // }
}
