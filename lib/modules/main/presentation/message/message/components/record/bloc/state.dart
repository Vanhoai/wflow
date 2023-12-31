import 'dart:io';

import 'package:equatable/equatable.dart';

class RecordState extends Equatable {
  final bool isRecord;
  final String timeRecord;
  final File? file;

  const RecordState({required this.isRecord, required this.timeRecord, required this.file});

  RecordState copyWith({
    bool? isRecord,
    String? timeRecord,
    File? file,
  }) {
    return RecordState(
      isRecord: isRecord ?? this.isRecord,
      timeRecord: timeRecord ?? this.timeRecord,
      file: file,
    );
  }

  @override
  List<Object?> get props => [isRecord, timeRecord, file];
}
