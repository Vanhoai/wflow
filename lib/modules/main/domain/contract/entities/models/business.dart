import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

@JsonSerializable()
class Business extends Equatable {
  final num id;
  final String state;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String overview;
  final num longitude;
  final num latitude;
  final String email;
  final String phone;
  final String name;
  final String logo;
  final String address;
  final num totalCollaborators;
  final num totalContracts;
  final num totalPosts;
  final String background;

  const Business({
    required this.id,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.overview,
    required this.longitude,
    required this.latitude,
    required this.background,
    required this.email,
    required this.phone,
    required this.name,
    required this.logo,
    required this.address,
    required this.totalCollaborators,
    required this.totalContracts,
    required this.totalPosts,
  });

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
  Business copyWith(
      {num? id,
      String? state,
      String? createdAt,
      String? updatedAt,
      dynamic deletedAt,
      String? overview,
      num? longitude,
      num? latitude,
      String? email,
      String? phone,
      String? name,
      String? logo,
      String? address,
      num? totalCollaborators,
      num? totalContracts,
      num? totalPosts,
      String? background}) {
    return Business(
        id: id ?? this.id,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        logo: logo ?? this.logo,
        address: address ?? this.address,
        totalCollaborators: totalCollaborators ?? this.totalCollaborators,
        totalContracts: totalContracts ?? this.totalContracts,
        totalPosts: totalPosts ?? this.totalPosts,
        background: background ?? this.background,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        overview: overview ?? this.overview,
        state: state ?? this.state,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  @override
  List<Object?> get props => [
        id,
        email,
        phone,
        name,
        address,
        totalCollaborators,
        totalContracts,
        totalPosts,
        logo,
        background,
        createdAt,
        deletedAt,
        longitude,
        latitude,
        overview,
        state,
        updatedAt
      ];
}
