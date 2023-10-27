import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';

part 'candidate_entity.g.dart';

@JsonSerializable()
class CandidateEntity extends Equatable {
  final int id;
  final CVEntity cv;
  final Worker worker;

  const CandidateEntity({required this.id, required this.cv, required this.worker});

  factory CandidateEntity.fromJson(Map<String, dynamic> json) => _$CandidateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateEntityToJson(this);

  CandidateEntity copyWith({int? id, CVEntity? cv, Worker? worker}) {
    return CandidateEntity(id: id ?? this.id, cv: cv ?? this.cv, worker: worker ?? this.worker);
  }

  @override
  List<Object?> get props => [id, cv, worker];
}

@JsonSerializable()
class Worker extends Equatable {
  final int id;
  final String name;
  final int role;
  final int age;
  final String address;
  final String email;
  final String phone;
  final bool isVerify;
  final String avatar;
  final String business;
  final String state;
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
    required this.state,
    required this.createdAt,
    required this.dob,
    required this.identifyCode,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => _$WorkerFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerToJson(this);

  Worker copyWith(
      {int? id,
      String? name,
      int? role,
      int? age,
      String? address,
      String? email,
      String? phone,
      bool? isVerify,
      String? avatar,
      String? business,
      String? state,
      String? createdAt,
      String? dob,
      String? identifyCode}) {
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
        state: state ?? this.state,
        dob: dob ?? this.dob,
        createdAt: createdAt ?? this.createdAt,
        identifyCode: identifyCode ?? this.identifyCode);
  }

  @override
  List<Object?> get props =>
      [id, name, role, age, address, email, phone, isVerify, avatar, business, state, dob, createdAt, identifyCode];
}
