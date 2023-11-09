import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends BaseEntity with EquatableMixin {
  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'business', defaultValue: 0)
  final int business;

  @JsonKey(name: 'email', defaultValue: '')
  final String email;

  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;

  @JsonKey(name: 'age', defaultValue: 0)
  final num age;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'dob', defaultValue: '')
  final String dob;

  @JsonKey(name: 'address', defaultValue: '')
  final String address;

  @JsonKey(name: 'isVerify', defaultValue: false)
  final bool isVerify;

  @JsonKey(name: 'identifyCode', defaultValue: '')
  final String identifyCode;

  @JsonKey(name: 'role', defaultValue: 0)
  final int role;

  @JsonKey(name: 'balance', defaultValue: 0)
  final int balance;

  @JsonKey(name: 'customerID', defaultValue: '')
  final String customerID;

  const UserEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.address,
    required this.age,
    required this.avatar,
    required this.dob,
    required this.email,
    required this.identifyCode,
    required this.isVerify,
    required this.name,
    required this.phone,
    required this.role,
    required this.business,
    required this.balance,
    required this.customerID,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  UserEntity copyWith({
    String? state,
    String? email,
    String? phone,
    String? avatar,
    num? age,
    String? name,
    String? dob,
    String? address,
    bool? isVerify,
    String? identifyCode,
    int? role,
    int? business,
    int? balance,
    String? customerID,
  }) {
    return UserEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
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
      business: business ?? this.business,
      balance: balance ?? this.balance,
      customerID: customerID ?? this.customerID,
    );
  }

  factory UserEntity.createEmpty() {
    return UserEntity(
      id: 0,
      email: '',
      phone: '',
      avatar: '',
      age: 0,
      name: '',
      dob: '',
      address: '',
      isVerify: false,
      identifyCode: '',
      role: 0,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      business: 0,
      balance: 0,
      customerID: '',
    );
  }

  @override
  List<Object?> get props =>
      [id, email, phone, avatar, age, name, dob, address, isVerify, identifyCode, role, balance, customerID];
}
