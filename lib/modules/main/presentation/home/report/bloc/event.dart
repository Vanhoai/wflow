import 'dart:io';

import 'package:equatable/equatable.dart';

class ReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddImageEvent extends ReportEvent {
  final List<File> files;

  AddImageEvent({required this.files});
  @override
  List<Object?> get props => [files];
}

class Submit extends ReportEvent {
  final String content;
  final String type;
  final num target;

  Submit({required this.content, required this.type, required this.target});
  @override
  List<Object?> get props => [content, type, target];
}
