import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel extends BaseEntity with EquatableMixin {
  CompanyModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.posts,
    required this.collaborators,
    required this.members,
    required this.state,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
    required this.logo,
    required this.background,
    required this.overview,
    required this.longitude,
    required this.latitude,
    required this.totalCollaborators,
    required this.totalPosts,
    required this.totalContracts,
    required this.balance,
    required this.creator,
  });

  @JsonKey(name: 'posts', defaultValue: 0)
  final int posts;

  @JsonKey(name: 'members', defaultValue: 0)
  final int members;

  @JsonKey(name: 'state', defaultValue: '')
  final String state;

  @JsonKey(name: 'email', defaultValue: '')
  final String email;

  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'address', defaultValue: '')
  final String address;

  @JsonKey(name: 'logo', defaultValue: null)
  final String logo;

  @JsonKey(name: 'background', defaultValue: '')
  final String background;

  @JsonKey(name: 'collaborators', defaultValue: null)
  final List<String> collaborators;

  @JsonKey(name: 'overview', defaultValue: '')
  final String overview;

  @JsonKey(name: 'longitude', defaultValue: 0)
  final double longitude;

  @JsonKey(name: 'latitude', defaultValue: 0)
  final double latitude;

  @JsonKey(name: 'totalCollaborators', defaultValue: 0)
  final int totalCollaborators;

  @JsonKey(name: 'totalPosts', defaultValue: 0)
  final int totalPosts;

  @JsonKey(name: 'totalContracts', defaultValue: 0)
  final int totalContracts;

  @JsonKey(name: 'balance', defaultValue: 0)
  final num balance;

  @JsonKey(name: 'creator', defaultValue: 0)
  final num creator;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);

  CompanyModel copyWith({
    int? posts,
    int? members,
    String? state,
    String? email,
    String? phone,
    String? name,
    String? address,
    String? logo,
    String? background,
    List<String>? collaborators,
    String? overview,
    double? longitude,
    double? latitude,
    int? totalCollaborators,
    int? totalPosts,
    int? totalContracts,
    num? balance,
    num? creator,
  }) {
    return CompanyModel(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      posts: posts ?? this.posts,
      members: members ?? this.members,
      state: state ?? this.state,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      address: address ?? this.address,
      logo: logo ?? this.logo,
      background: background ?? this.background,
      collaborators: collaborators ?? this.collaborators,
      overview: overview ?? this.overview,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      totalCollaborators: totalCollaborators ?? this.totalCollaborators,
      totalPosts: totalPosts ?? this.totalPosts,
      totalContracts: totalContracts ?? this.totalContracts,
      balance: balance ?? this.balance,
      creator: creator ?? this.creator,
    );
  }

  factory CompanyModel.createEmpty() {
    return CompanyModel(
      posts: 0,
      members: 0,
      state: '',
      email: '',
      phone: '',
      name: '',
      address: '',
      collaborators: [],
      id: 0,
      logo: '',
      background: '',
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      overview: '',
      longitude: 0,
      latitude: 0,
      totalCollaborators: 0,
      totalPosts: 0,
      totalContracts: 0,
      balance: 0,
      creator: 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        logo,
        background,
        posts,
        collaborators,
        members,
        state,
        email,
        phone,
        name,
        address,
        overview,
        longitude,
        latitude,
        totalCollaborators,
        totalPosts,
        totalContracts,
        balance,
        creator,
      ];
}
