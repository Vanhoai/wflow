import 'package:equatable/equatable.dart';

abstract class AddBusinessEvent extends Equatable {
  const AddBusinessEvent();

  @override
  List get props => [];
}

class InitAddBusinessEvent extends AddBusinessEvent {}

class SearchAddBusinessEvent extends AddBusinessEvent {
  final String txtSearch;

  const SearchAddBusinessEvent({this.txtSearch = ''});

  SearchAddBusinessEvent coppyWith({String? txtSearch}) {
    return SearchAddBusinessEvent(txtSearch: txtSearch ?? this.txtSearch);
  }

  @override
  List get props => [txtSearch];
}

class ChangedIconClearAddBusinessEvent extends AddBusinessEvent {
  final String txtSearch;

  const ChangedIconClearAddBusinessEvent({this.txtSearch = ''});

  ChangedIconClearAddBusinessEvent coppyWith({String? txtSearch}) {
    return ChangedIconClearAddBusinessEvent(
        txtSearch: txtSearch ?? this.txtSearch);
  }

  @override
  List get props => [txtSearch];
}

class ScrollAddBusinessEvent extends AddBusinessEvent {}
