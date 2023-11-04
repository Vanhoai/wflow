import 'package:equatable/equatable.dart';

abstract class SearchWorkEvent extends Equatable {
  const SearchWorkEvent();

  @override
  List<Object?> get props => [];
}

class InitSearchWorkEvent extends SearchWorkEvent {
  const InitSearchWorkEvent();

  @override
  List<Object?> get props => [];
}

class ChangedSearchWorkEvent extends SearchWorkEvent {
  final String txtSearch;

  const ChangedSearchWorkEvent({required this.txtSearch});

  @override
  List<Object?> get props => [txtSearch];
}

class ChangedIconClearSearchWorkEvent extends SearchWorkEvent {
  final String txtSearch;

  const ChangedIconClearSearchWorkEvent({required this.txtSearch});

  @override
  List<Object?> get props => [txtSearch];
}

class ScrollSearchWorkEvent extends SearchWorkEvent {
  const ScrollSearchWorkEvent();

  @override
  List<Object?> get props => [];
}

class RefreshSearchWorkEvent extends SearchWorkEvent {
  const RefreshSearchWorkEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoreSearchWorkEvent extends SearchWorkEvent {
  final bool isLoadMore;
  const LoadMoreSearchWorkEvent({this.isLoadMore = false});

  LoadMoreSearchWorkEvent coppyWith({bool? isLoadMore}) {
    return LoadMoreSearchWorkEvent(isLoadMore: isLoadMore ?? this.isLoadMore);
  }

  @override
  List<Object?> get props => [isLoadMore];
}
