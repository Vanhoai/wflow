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

  @JsonKey(name: 'collaborators', defaultValue: null)
  final List<String> collaborators;

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
    List<String>? collaborators,
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
      collaborators: collaborators ?? this.collaborators,
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
      createdAt: '',
      updatedAt: '',
      deletedAt: '',
      logo: '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        logo,
        posts,
        collaborators,
        members,
        state,
        email,
        phone,
        name,
        address,
      ];
}
