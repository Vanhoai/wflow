part of 'bloc.dart';

abstract class WorkEvent {}

class WorkInitialEvent extends WorkEvent {}

class OnSelectCategoryEvent extends WorkEvent {
  final String category;

  OnSelectCategoryEvent({required this.category});
}

class LoadMoreEvent extends WorkEvent {}

class RefreshEvent extends WorkEvent {}
