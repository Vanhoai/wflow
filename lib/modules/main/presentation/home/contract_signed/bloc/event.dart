part of 'bloc.dart';

abstract class ContractSignedEvent {}

class ContractSignedEventFetch extends ContractSignedEvent {}

class ContractSignedEventRefresh extends ContractSignedEvent {}

class ContractSignedEventLoadMore extends ContractSignedEvent {}

class ContractSignedSearchEvent extends ContractSignedEvent {
  final String search;

  ContractSignedSearchEvent(this.search);
}
