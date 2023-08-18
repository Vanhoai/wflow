import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String avatar;
  final String username;
  final String phoneNumber;

  const UserModel({
    required this.email,
    required this.avatar,
    required this.username,
    required this.phoneNumber,
  });

  static UserModel empty() {
    return const UserModel(
      email: "",
      avatar: "",
      username: "",
      phoneNumber: "",
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      avatar: json['avatar'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'avatar': avatar,
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  List<Object> get props => [email, avatar, username, phoneNumber];
}
