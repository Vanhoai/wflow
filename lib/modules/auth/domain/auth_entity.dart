import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final bool isSignIn;
  final User user;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.isSignIn,
    required this.user,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => _$AuthEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthEntityToJson(this);

  AuthEntity copyWith({
    String? accessToken,
    String? refreshToken,
    bool? isSignIn,
    User? user,
  }) {
    return AuthEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isSignIn: isSignIn ?? this.isSignIn,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, isSignIn, user];
}

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String name;
  final int role;
  final int age;
  final String address;
  final String email;
  final String phone;
  final bool isVerify;
  final String avatar;

  const User({
    required this.id,
    required this.name,
    required this.role,
    required this.age,
    required this.address,
    required this.email,
    required this.phone,
    required this.isVerify,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? name,
    int? role,
    int? age,
    String? address,
    String? email,
    String? phone,
    bool? isVerify,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      age: age ?? this.age,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isVerify: isVerify ?? this.isVerify,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  List<Object?> get props => [id, name, role, age, address, email, phone, isVerify, avatar];
}
