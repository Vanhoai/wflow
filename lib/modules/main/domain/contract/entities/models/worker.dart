import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'worker.g.dart';

@JsonSerializable()
class Worker extends Equatable {
  final num id;
  final String name;
  final num role;
  final num age;
  final String address;
  final String email;
  final String phone;
  final bool isVerify;
  final String avatar;
  final num business;
  final String createdAt;
  final String dob;
  final String identifyCode;

  const Worker({
    required this.id,
    required this.name,
    required this.role,
    required this.age,
    required this.address,
    required this.email,
    required this.phone,
    required this.isVerify,
    required this.avatar,
    required this.business,
    required this.createdAt,
    required this.dob,
    required this.identifyCode,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => _$WorkerFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerToJson(this);

  Worker copyWith({
    num? id,
    String? name,
    num? role,
    num? age,
    String? address,
    String? email,
    String? phone,
    bool? isVerify,
    String? avatar,
    num? business,
    String? createdAt,
    String? dob,
    String? identifyCode,
  }) {
    return Worker(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      age: age ?? this.age,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isVerify: isVerify ?? this.isVerify,
      avatar: avatar ?? this.avatar,
      business: business ?? this.business,
      dob: dob ?? this.dob,
      createdAt: createdAt ?? this.createdAt,
      identifyCode: identifyCode ?? this.identifyCode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        age,
        address,
        email,
        phone,
        isVerify,
        avatar,
        business,
        dob,
        createdAt,
        identifyCode,
      ];
}
