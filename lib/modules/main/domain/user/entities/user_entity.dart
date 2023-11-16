import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends BaseEntity with EquatableMixin {
  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatar;

  @JsonKey(name: 'background', defaultValue: '')
  final String background;

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

  @JsonKey(name: 'bio', defaultValue: '')
  final String bio;

  @JsonKey(name: 'workDone', defaultValue: 0)
  final num workDone;

  @JsonKey(name: 'reputation', defaultValue: 5)
  final num reputation;

  const UserEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.address,
    required this.age,
    required this.avatar,
    required this.background,
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
    required this.bio,
    required this.workDone,
    required this.reputation,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  UserEntity copyWith({
    String? state,
    String? email,
    String? phone,
    String? avatar,
    String? background,
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
    String? bio,
    num? workDone,
    num? reputation,
  }) {
    return UserEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      background: background ?? this.background,
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
      bio: bio ?? this.bio,
      workDone: workDone ?? this.workDone,
      reputation: reputation ?? this.reputation,
    );
  }

  factory UserEntity.createEmpty() {
    return UserEntity(
      id: 0,
      email: '',
      phone: '',
      avatar: '',
      background: '',
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
      bio: '',
      workDone: 0,
      reputation: 5,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        phone,
        avatar,
        background,
        age,
        name,
        dob,
        address,
        isVerify,
        identifyCode,
        role,
        balance,
        customerID,
        bio,
        workDone,
        reputation,
      ];
}
