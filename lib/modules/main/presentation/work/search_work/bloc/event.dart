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
