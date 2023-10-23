part of 'bloc.dart';

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class OnSelectCategoryEvent extends HomeEvent {
  final String category;

  OnSelectCategoryEvent(this.category);
}
