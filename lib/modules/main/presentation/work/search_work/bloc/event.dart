import 'package:equatable/equatable.dart';

abstract class SearchWorkEvent extends Equatable {
  const SearchWorkEvent();

  @override
  List<Object?> get props => [];
}

class ChangedSearchWorkEvent extends SearchWorkEvent {
  final String txtSearch;

  const ChangedSearchWorkEvent({required this.txtSearch});

  @override
  List<Object?> get props => [txtSearch];
}
