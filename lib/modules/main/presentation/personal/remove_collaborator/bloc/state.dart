import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class RemoveCollaboratorState extends Equatable {
  final List<UserEntity> users;
  final List<int> usersChecked;

  const RemoveCollaboratorState({
    this.users = const [],
    this.usersChecked = const [],
  });

  @override
  List get props => [users, usersChecked];
}
