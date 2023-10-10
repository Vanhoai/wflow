import 'package:equatable/equatable.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';

class VideoCallEvent extends Equatable {
  const VideoCallEvent();
  @override
  List<Object?> get props => [];
}

class VideoCallConnectEvent extends VideoCallEvent{
  const VideoCallConnectEvent();
}

class OnCallIncomingEvent extends VideoCallEvent {
  final StringeeCall2 call;

  OnCallIncomingEvent({required this.call});
}