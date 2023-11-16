import 'dart:io';

class RequestReportModel {
  final List<File> files;
  final String content;
  final num target;
  final String type;

  RequestReportModel({required this.files, required this.content, required this.target, required this.type});
}
