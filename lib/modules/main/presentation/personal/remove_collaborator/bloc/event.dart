import 'package:equatable/equatable.dart';

abstract class RemoveCollaboratorEvent extends Equatable {
  @override
  List get props => [];
}

class GetAllCollaboratorEvent extends RemoveCollaboratorEvent {}

class ScrollCollaboratorEvent extends RemoveCollaboratorEvent {}

class LoadMoreCollaboratorEvent extends RemoveCollaboratorEvent {
  final bool isLoadMore;

  LoadMoreCollaboratorEvent({this.isLoadMore = true});

  @override
  List get props => [isLoadMore];
}

class CheckedCollaboratorEvent extends RemoveCollaboratorEvent {
  final bool isChecked;
  final int id;

  CheckedCollaboratorEvent({required this.isChecked, required this.id});

  @override
  List get props => [isChecked, id];
}

class DeleteCollaboratorEvent extends RemoveCollaboratorEvent {}
