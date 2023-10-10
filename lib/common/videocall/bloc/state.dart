

import 'package:equatable/equatable.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';

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

class CallInComing extends VideoCallState {
  final StringeeCall2 call;
  const CallInComing({required this.call});
}