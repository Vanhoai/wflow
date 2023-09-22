

import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState>{
  late FlutterSoundRecorder _recordingSession;
  late String pathToAudio;
  RecordBloc():super(initState()){
    pathToAudio = '/sdcard/Download/temp.wav';
    _recordingSession = FlutterSoundRecorder();
    on<ShowRecordVoiceEvent>(showRecordVoice);
    on<HandleStartRecordEvent>(handleStartRecord);
    on<HandleStopRecordEvent>(handleStopRecord);
    _recordingSession.onProgress;
  }



  static RecordState initState(){
    return RecordState(isShow: false,isRecord: false,timeRecord:  "00:00:00", file: null);
  }

  FutureOr<void> showRecordVoice(ShowRecordVoiceEvent event, Emitter<RecordState> emit) async {
    if(!state.isRecord)
    {
      final permissionRecord = await Permission.microphone.request();
      final permissionFile = await Permission.storage.request();
      if (permissionRecord != PermissionStatus.granted ||
          permissionFile != PermissionStatus.granted) {
        throw 'Chua co quyen mic';
      }
    }
    emit(state.copyWith(isShow: !state.isShow));

  }

  FutureOr<void> handleStartRecord(HandleStartRecordEvent event, Emitter<RecordState> emit) async {
    print("Hello ");
    await _recordingSession.openRecorder();
    await _recordingSession
        .setSubscriptionDuration(const Duration(milliseconds: 10));

    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );

    await emit.forEach(_recordingSession.onProgress as Stream<RecordingDisposition>, onData: (e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss', 'en_GB').format(date);
      return state.copyWith(
        timeRecord: timeText,
        isRecord: true,
      );
    });

  }




  FutureOr<void> handleStopRecord(HandleStopRecordEvent event, Emitter<RecordState> emit) async{
    await _recordingSession.stopRecorder();
    File file = File(pathToAudio);
    await _recordingSession.closeRecorder();
    emit(state.copyWith(isRecord: false, file: file));
  }

  @override
  Future<void> close() {
    try{
      _recordingSession.closeRecorder();
    }catch (e) {
      print(e);
    }
    return super.close();

  }


}