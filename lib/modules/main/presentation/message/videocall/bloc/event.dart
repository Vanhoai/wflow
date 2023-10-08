import 'package:equatable/equatable.dart';

class VideoCallEvent extends Equatable {
  const VideoCallEvent();
  @override
  List<Object?> get props => [];
}

class VideoCallConnectEvent extends VideoCallEvent{
  const VideoCallConnectEvent();
}