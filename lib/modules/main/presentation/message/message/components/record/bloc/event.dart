


import 'package:equatable/equatable.dart';

sealed class RecordEvent extends Equatable {


  @override
  List<Object?> get props => [];

}





class HandleStartRecordEvent extends RecordEvent {
  HandleStartRecordEvent();

  @override
  List<Object?> get props => [];
}


class HandleStopRecordEvent extends RecordEvent{
  HandleStopRecordEvent();

  @override
  List<Object?> get props => [];
}

class HandleRemoveRecordEvent extends RecordEvent {
  HandleRemoveRecordEvent();
}
class CleanAfterSendFile extends RecordEvent {
  CleanAfterSendFile();
}

