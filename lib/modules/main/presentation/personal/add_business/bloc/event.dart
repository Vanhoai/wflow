abstract class AddBusinessEvent {}

class InitAddBusinessEvent extends AddBusinessEvent {}

class SearchAddBusinessEvent extends AddBusinessEvent {
  final String search;

  SearchAddBusinessEvent({required this.search});
}

class RefreshAddBusinessEvent extends AddBusinessEvent {}

class UserCheckedAddBusinessEvent extends AddBusinessEvent {
  final bool isChecked;
  final int id;

  UserCheckedAddBusinessEvent({
    required this.isChecked,
    required this.id,
  });
}

class AddCollaboratorAddBusinessEvent extends AddBusinessEvent {}

class LoadMoreAddBusinessEvent extends AddBusinessEvent {}
