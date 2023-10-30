import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

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

  const Business({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
    required this.totalCollaborators,
    required this.totalContracts,
    required this.totalPosts,
  });

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
  Business copyWith({
    num? id,
    String? email,
    String? phone,
    String? name,
    String? address,
    num? totalCollaborators,
    num? totalContracts,
    num? totalPosts,
  }) {
    return Business(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      address: address ?? this.address,
      totalCollaborators: totalCollaborators ?? this.totalCollaborators,
      totalContracts: totalContracts ?? this.totalContracts,
      totalPosts: totalPosts ?? this.totalPosts,
    );
  }

  @override
  List<Object?> get props => [id, email, phone, name, address, totalCollaborators, totalContracts, totalPosts];
}
