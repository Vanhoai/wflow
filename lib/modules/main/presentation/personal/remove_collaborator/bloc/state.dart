import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class RemoveCollaboratorState extends Equatable {
  final List<UserEntity> users;
  final Meta meta;
  final List<int> usersChecked;

  const RemoveCollaboratorState({
    required this.users,
    required this.usersChecked,
    required this.meta,
  });

  RemoveCollaboratorState copyWith({
    List<UserEntity>? users,
    List<int>? usersChecked,
    Meta? meta,
  }) {
    return RemoveCollaboratorState(
      users: users ?? this.users,
      usersChecked: usersChecked ?? this.usersChecked,
      meta: meta ?? this.meta,
    );
  }

  @override
  List get props => [users, usersChecked, meta];
}
