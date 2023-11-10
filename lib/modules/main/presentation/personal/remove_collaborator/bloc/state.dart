import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class RemoveCollaboratorState extends Equatable {
  final List<UserEntity> users;
  final List<int> usersChecked;
  final int page;
  final bool isLoadMore;

  const RemoveCollaboratorState({
    this.users = const [],
    this.usersChecked = const [],
    this.page = 1,
    this.isLoadMore = false,
  });

  RemoveCollaboratorState copyWith({
    List<UserEntity>? users,
    List<int>? usersChecked,
    int? page,
    bool? isLoadMore,
  }) =>
      RemoveCollaboratorState(
        users: users ?? this.users,
        usersChecked: usersChecked ?? this.usersChecked,
        page: page ?? this.page,
        isLoadMore: isLoadMore ?? this.isLoadMore,
      );

  @override
  List get props => [users, usersChecked, page, isLoadMore];
}

class LoadCollaboratorFailedState extends RemoveCollaboratorState {
  final String message;

  const LoadCollaboratorFailedState({required this.message});

  @override
  List get props => [message];
}

class RemoveCollaboratorSuccessedState extends RemoveCollaboratorState {
  final String message;

  const RemoveCollaboratorSuccessedState({required this.message});

  @override
  List get props => [message];
}

class RemoveCollaboratorFailedState extends RemoveCollaboratorState {
  final String message;

  const RemoveCollaboratorFailedState({required this.message});

  @override
  List get props => [message];
}
