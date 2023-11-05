import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_collaborator_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddCollaboratorModel extends Equatable {
  final int business;
  final List<int> users;

  const AddCollaboratorModel({required this.business, required this.users});

  AddCollaboratorModel copyWith({int? business, List<int>? users}) =>
      AddCollaboratorModel(
        business: business ?? this.business,
        users: users ?? this.users,
      );

  factory AddCollaboratorModel.fromJson(Map<String, dynamic> json) =>
      _$AddCollaboratorModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCollaboratorModelToJson(this);

  @override
  List<Object?> get props => [business, users];
}
