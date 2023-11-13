import 'dart:io';

class RequestAddCV {
  final File cv;
  final String title;
  final String content;

  RequestAddCV({required this.cv, required this.title, required this.content});
}
