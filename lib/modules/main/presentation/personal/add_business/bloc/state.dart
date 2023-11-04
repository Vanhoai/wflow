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
