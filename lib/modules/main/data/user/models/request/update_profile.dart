import 'dart:io';

class RequestUpdateProfile {
  final File? avatar;
  final File? background;
  final String address;
  final String bio;
  final num dob;
  final num age;

  RequestUpdateProfile(
      {required this.avatar,
      required this.background,
      required this.address,
      required this.bio,
      required this.dob,
      required this.age});
}
