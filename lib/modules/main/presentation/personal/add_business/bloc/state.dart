import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class AddBusinessState extends Equatable {
  final List<UserEntity> users;
  final Meta meta;
  final List<int> usersChecked;
  final bool isLoadMore;
  final bool isLoading;

  const AddBusinessState({
    required this.users,
    required this.usersChecked,
    required this.meta,
    this.isLoadMore = false,
    this.isLoading = false,
  });

  AddBusinessState copyWith({
    List<UserEntity>? users,
    List<int>? usersChecked,
    Meta? meta,
    bool? isLoadMore,
    bool? isLoading,
  }) {
    return AddBusinessState(
      users: users ?? this.users,
      usersChecked: usersChecked ?? this.usersChecked,
      meta: meta ?? this.meta,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List get props => [users, usersChecked, meta, isLoadMore, isLoading];
}
