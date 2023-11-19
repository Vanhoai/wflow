import 'package:equatable/equatable.dart';

abstract class SearchWorkEvent extends Equatable {
  const SearchWorkEvent();

  @override
  List<Object?> get props => [];
}

class InitSearchWorkEvent extends SearchWorkEvent {}

class ChangedSearchWorkEvent extends SearchWorkEvent {
  final String txtSearch;

  const ChangedSearchWorkEvent({required this.txtSearch});

  @override
  List<Object?> get props => [txtSearch];
}

class ScrollSearchWorkEvent extends SearchWorkEvent {}

class RefreshSearchWorkEvent extends SearchWorkEvent {}

class ChangedIconClearSearchWorkEvent extends SearchWorkEvent {
  final String txtSearch;

  const ChangedIconClearSearchWorkEvent({required this.txtSearch});

  @override
  List<Object?> get props => [txtSearch];
}

class ToggleBookmarkSearchWorkEvent extends SearchWorkEvent {
  final int id;
  final int index;
  final bool isBookmarkeded;

  const ToggleBookmarkSearchWorkEvent({
    required this.id,
    required this.index,
    required this.isBookmarkeded,
  });

  @override
  List get props => [id, index, isBookmarkeded];
}
