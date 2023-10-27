import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ContractEntity extends Equatable {
  final String cv;
  final num id;
  final String title;
  final String content;
  final String introduction;
  final String salary;
  final bool businessSigned;
  final bool workerSigned;
  final Worker worker;
  final Business business;

  const ContractEntity(
      {required this.cv,
      required this.id,
      required this.title,
      required this.content,
      required this.introduction,
      required this.salary,
      required this.businessSigned,
      required this.workerSigned,
      required this.worker,
      required this.business});

  factory ContractEntity.fromJson(Map<String, dynamic> json) => _$ContractEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ContractEntityToJson(this);

  ContractEntity copyWith(
      {String? cv,
      num? id,
      String? title,
      String? content,
      String? introduction,
      String? salary,
      bool? workerSigned,
      bool? businessSigned,
      Worker? worker,
      Business? business}) {
    return ContractEntity(
        cv: cv ?? this.cv,
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        introduction: introduction ?? this.introduction,
        salary: salary ?? this.salary,
        businessSigned: businessSigned ?? this.businessSigned,
        workerSigned: workerSigned ?? this.workerSigned,
        worker: worker ?? this.worker,
        business: business ?? this.business);
  }

  @override
  List<Object?> get props =>
      [cv, id, title, content, introduction, salary, businessSigned, workerSigned, worker, business];
}

@JsonSerializable()
class Business extends Equatable {
  final num id;
  final String email;
  final String phone;
  final String name;
  final String address;
  final num totalCollaborators;
  final num totalContracts;
  final num totalPosts;

  const Business(
      {required this.id,
      required this.email,
      required this.phone,
      required this.name,
      required this.address,
      required this.totalCollaborators,
      required this.totalContracts,
      required this.totalPosts});

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
  Business copyWith(
      {num? id,
      String? email,
      String? phone,
      String? name,
      String? address,
      num? totalCollaborators,
      num? totalContracts,
      num? totalPosts}) {
    return Business(
        id: id ?? this.id,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        address: address ?? this.address,
        totalCollaborators: totalCollaborators ?? this.totalCollaborators,
        totalContracts: totalContracts ?? this.totalContracts,
        totalPosts: totalPosts ?? this.totalPosts);
  }

  @override
  List<Object?> get props => [id, email, phone, name, address, totalCollaborators, totalContracts, totalPosts];
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
