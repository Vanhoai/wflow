import 'dart:io';

class RequestFaceMatch {
  final File face;
  final File front;
  final File back;
  final String name;
  final String identifyCode;
  final String dob;

  RequestFaceMatch(
      {required this.face,
      required this.front,
      required this.back,
      required this.name,
      required this.identifyCode,
      required this.dob});
}
