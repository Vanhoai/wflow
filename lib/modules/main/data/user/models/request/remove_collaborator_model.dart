import 'package:json_annotation/json_annotation.dart';

part 'remove_collaborator_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoveCollaboratorModel {
  final int business;
  final List<int> users;

  RemoveCollaboratorModel({required this.business, required this.users});

  factory RemoveCollaboratorModel.fromJson(Map<String, dynamic> json) =>
      _$RemoveCollaboratorModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveCollaboratorModelToJson(this);
}
