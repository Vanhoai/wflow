import 'package:equatable/equatable.dart';

abstract class AddBusinessEvent extends Equatable {
  const AddBusinessEvent();

  @override
  List get props => [];
}

class InitAddBusinessEvent extends AddBusinessEvent {}

class SearchAddBusinessEvent extends AddBusinessEvent {
  final String txtSearch;

  const SearchAddBusinessEvent({this.txtSearch = ''});

  SearchAddBusinessEvent coppyWith({String? txtSearch}) {
    return SearchAddBusinessEvent(txtSearch: txtSearch ?? this.txtSearch);
  }

  @override
  List get props => [txtSearch];
}

class ChangedIconClearAddBusinessEvent extends AddBusinessEvent {
  final String txtSearch;

  const ChangedIconClearAddBusinessEvent({this.txtSearch = ''});

  ChangedIconClearAddBusinessEvent coppyWith({String? txtSearch}) {
    return ChangedIconClearAddBusinessEvent(
        txtSearch: txtSearch ?? this.txtSearch);
  }

  @override
  List get props => [txtSearch];
}

class ScrollAddBusinessEvent extends AddBusinessEvent {
  const ScrollAddBusinessEvent();

  @override
  List get props => [];
}

class LoadMoreAddBusinessEvent extends AddBusinessEvent {
  final bool isLoadMore;

  const LoadMoreAddBusinessEvent({this.isLoadMore = false});

  LoadMoreAddBusinessEvent copyWith({bool? isLoadMore}) =>
      LoadMoreAddBusinessEvent(isLoadMore: isLoadMore ?? this.isLoadMore);

  @override
  List get props => [isLoadMore];
}

class RefreshAddBusinessEvent extends AddBusinessEvent {
  const RefreshAddBusinessEvent();

  @override
  List<Object?> get props => [];
}

class UserCheckedAddBusinessEvent extends AddBusinessEvent {
  final bool isChecked;
  final int id;

  const UserCheckedAddBusinessEvent(
      {required this.isChecked, required this.id});

  @override
  List get props => [isChecked, id];
}

class AddCollaboratorAddBusinessEvent extends AddBusinessEvent {
  final List<int> usersChecked;

  const AddCollaboratorAddBusinessEvent({required this.usersChecked});

  @override
  List get props => [usersChecked];
}
