part of 'bloc.dart';

abstract class WorkEvent {}

class WorkInitialEvent extends WorkEvent {}

class OnSelectCategoryEvent extends WorkEvent {
  final String category;

  OnSelectCategoryEvent({required this.category});
}

class LoadMoreEvent extends WorkEvent {}

class RefreshEvent extends WorkEvent {}

class ToggleBookmarkWorkEvent extends WorkEvent {
  final int id;
  final int index;
  final bool isBookmarkeded;

  ToggleBookmarkWorkEvent({
    required this.id,
    required this.index,
    required this.isBookmarkeded,
  });
}

class GetRelationPostEvent extends WorkEvent {
  GetRelationPostEvent();
}
