abstract class RemoveCollaboratorEvent {}

class GetAllCollaboratorEvent extends RemoveCollaboratorEvent {}

class LoadMoreCollaboratorEvent extends RemoveCollaboratorEvent {
  final bool isLoadMore;

  LoadMoreCollaboratorEvent({this.isLoadMore = true});
}

class CheckedCollaboratorEvent extends RemoveCollaboratorEvent {
  final bool isChecked;
  final int id;

  CheckedCollaboratorEvent({required this.isChecked, required this.id});
}

class DeleteCollaboratorEvent extends RemoveCollaboratorEvent {}
