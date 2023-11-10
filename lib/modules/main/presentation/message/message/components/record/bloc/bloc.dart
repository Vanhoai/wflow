import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:intl/intl.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/state.dart';
import 'package:path_provider/path_provider.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  late FlutterSoundRecorder _recordingSession;
  late String path;

  RecordBloc() : super(initState()) {
    _recordingSession = FlutterSoundRecorder();
    on<HandleStartRecordEvent>(handleStartRecord);
    on<HandleStopRecordEvent>(handleStopRecord);
    on<HandleRemoveRecordEvent>(handleRemoveRecord);
  }

  static RecordState initState() {
    return const RecordState(isRecord: false, timeRecord: 'Nhấn để ghi âm', file: null);
  }

  FutureOr<void> handleStartRecord(HandleStartRecordEvent event, Emitter<RecordState> emit) async {
    final cache = await cachePath;
    path = '$cache/temp.mp4';
    await _recordingSession.openRecorder();
    await _recordingSession.setSubscriptionDuration(const Duration(milliseconds: 10));

    await _recordingSession.startRecorder(
      toFile: path,
      codec: Codec.aacMP4,
    );

    await emit.forEach(_recordingSession.onProgress as Stream<RecordingDisposition>, onData: (e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds, isUtc: true);
      var timeText = DateFormat('mm:ss', 'en_GB').format(date);
      return state.copyWith(
        timeRecord: timeText,
        isRecord: true,
      );
    });
  }

  FutureOr<void> handleStopRecord(HandleStopRecordEvent event, Emitter<RecordState> emit) async {
    await _recordingSession.stopRecorder();
    File file = File(path);
    await _recordingSession.closeRecorder();
    emit(state.copyWith(isRecord: false, file: file));
  }

  @override
  Future<void> close() {
    try {
      _recordingSession.closeRecorder();
    } catch (e) {
      print(e);
    }
    return super.close();
  }

  Future<String> get cachePath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  FutureOr<void> handleRemoveRecord(HandleRemoveRecordEvent event, Emitter<RecordState> emit) async {
    try {
      await state.file?.delete(recursive: true);
    } catch (e) {
      print(e);
    } finally {
      emit(state.copyWith(timeRecord: "Nhấn để ghi âm"));
    }
  }
}
