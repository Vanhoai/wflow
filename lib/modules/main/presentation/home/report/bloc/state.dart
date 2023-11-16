import 'dart:io';

import 'package:equatable/equatable.dart';

class ReportState extends Equatable {
  final List<File> files;

  const ReportState({required this.files});

  ReportState copyWith({List<File>? files}) {
    return ReportState(files: files ?? this.files);
  }

  @override
  List<Object?> get props => [files];
}
