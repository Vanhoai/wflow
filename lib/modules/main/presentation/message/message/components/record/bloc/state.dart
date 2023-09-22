import 'dart:io';

import 'package:equatable/equatable.dart';

class RecordState extends Equatable {
  late bool isShow;
  late bool isRecord;
  final String timeRecord;
  File? file;
  RecordState({required this.isShow, required this.isRecord, required this.timeRecord, required this.file});

  RecordState copyWith({
    bool? isShow,
    bool? isRecord,
    String? timeRecord,
    File? file,

  }) {
    return RecordState(
      isShow: isShow ?? this.isShow,
      isRecord: isRecord ?? this.isRecord,
      timeRecord: timeRecord ?? this.timeRecord,
      file: file ?? this.file
    );
  }


  @override
  List<Object?> get props => [isShow,isRecord,timeRecord,file];

}