import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class AddBusinessState extends Equatable {
  final List<UserEntity> users;
  final bool isHiddenSuffixIcon;
  final int page;
  final String txtSearch;
  final bool isLoadMore;
  final List<int> usersChecked;

  const AddBusinessState({
    this.users = const [],
    this.isHiddenSuffixIcon = true,
    this.page = 1,
    this.txtSearch = '',
    this.isLoadMore = false,
    this.usersChecked = const [],
  });

  AddBusinessState copyWith({
    List<UserEntity>? users,
    bool? isHiddenSuffixIcon,
    int? page,
    String? txtSearch,
    bool? isLoadMore,
    List<int>? usersChecked,
  }) {
    return AddBusinessState(
      users: users ?? this.users,
      isHiddenSuffixIcon: isHiddenSuffixIcon ?? this.isHiddenSuffixIcon,
      page: page ?? this.page,
      txtSearch: txtSearch ?? this.txtSearch,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      usersChecked: usersChecked ?? this.usersChecked,
    );
  }

  @override
  List get props => [
        users,
        isHiddenSuffixIcon,
        page,
        txtSearch,
        isLoadMore,
        usersChecked,
      ];
}

class LoadFailureAddBusinessState extends AddBusinessState {
  final String message;

  const LoadFailureAddBusinessState({required this.message});

  @override
  List get props => [message];
}

class AddCollaboratorFailedAddBusinessState extends AddBusinessState {
  final String message;

  const AddCollaboratorFailedAddBusinessState({required this.message});

  @override
  List get props => [message];
}

class AddCollaboratorSuccessedAddBusinessState extends AddBusinessState {
  final String message;

  const AddCollaboratorSuccessedAddBusinessState({required this.message});

  @override
  List get props => [message];
}
