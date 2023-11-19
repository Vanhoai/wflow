part of 'bloc.dart';

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class OnSelectCategoryEvent extends HomeEvent {
  final String category;

  OnSelectCategoryEvent(this.category);
}

class ToggleBookmarkHomeEvent extends HomeEvent {
  final int id;
  final int index;
  final bool isBookmarkeded;

  ToggleBookmarkHomeEvent({
    required this.id,
    required this.index,
    required this.isBookmarkeded,
  });
}

class ToggleBookmarkRecentHomeEvent extends HomeEvent {
  final int id;
  final int index;
  final bool isBookmarkeded;

  ToggleBookmarkRecentHomeEvent({
    required this.id,
    required this.index,
    required this.isBookmarkeded,
  });
}
