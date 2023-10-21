import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final num? id;
  final String? state;
  final String? email;
  final String? phone;
  final String? avatar;
  final num? age;
  final String? name;
  final num? dob;
  final String? address;
  final bool? isVerify;
  final String? identifyCode;
  final int? role;

  const UserEntity({
    this.id,
    this.state,
    this.email,
    this.phone,
    this.avatar,
    this.age,
    this.name,
    this.dob,
    this.address,
    this.isVerify,
    this.identifyCode,
    this.role,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  UserEntity copyWith({
    num? id,
    String? state,
    String? email,
    String? phone,
    String? avatar,
    num? age,
    String? name,
    num? dob,
    String? address,
    bool? isVerify,
    String? identifyCode,
    int? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      state: state ?? this.state,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      age: age ?? this.age,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      isVerify: isVerify ?? this.isVerify,
      identifyCode: identifyCode ?? this.identifyCode,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [id, state, email, phone, avatar, age, name, dob, address, isVerify, identifyCode, role];
}
