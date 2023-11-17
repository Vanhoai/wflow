import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List get props => [];
}

class InitBookmarkEvent extends BookmarkEvent {}

class ScrollBookmarkEvent extends BookmarkEvent {}

class ToggleBookmarkEvent extends BookmarkEvent {
  final int id;

  ToggleBookmarkEvent({required this.id});

  @override
  List get props => [id];
}
