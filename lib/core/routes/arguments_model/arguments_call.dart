import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';

class ArgumentsCall {
  final StringeeClient client;
  final StringeeCall2? stringeeCall2;
  final String toUserId;
  final String fromUserId;
  final StringeeObjectEventType callType;
  final bool showIncomingUi;
  final bool isVideoCall;

  ArgumentsCall({required this.client, this.stringeeCall2, required this.toUserId, required this.fromUserId, required this.callType, required this.showIncomingUi, required this.isVideoCall});

}
