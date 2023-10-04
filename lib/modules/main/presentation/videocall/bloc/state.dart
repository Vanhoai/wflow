

import 'package:equatable/equatable.dart';

class VideoCallState extends Equatable {
  const VideoCallState();
  @override
  List<Object?> get props => [];
}
class InitVideoCallSate extends VideoCallState{
  const InitVideoCallSate();
}

class CallVideoConnect extends VideoCallState {
  const CallVideoConnect();
}