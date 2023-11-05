import 'package:equatable/equatable.dart';

class ChatBusinessState extends Equatable {
  final List users;
  final String txtSearch;
  final bool isHiddenClearIcon;

  const ChatBusinessState({
    this.users = const [],
    this.txtSearch = '',
    this.isHiddenClearIcon = true,
  });

  @override
  List get props => [users, txtSearch, isHiddenClearIcon];
}
