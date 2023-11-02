part of 'bloc.dart';

abstract class ContractWaitingSignEvent {}

class ContractWaitingSignEventFetch extends ContractWaitingSignEvent {}

class ContractWaitingSignEventSearch extends ContractWaitingSignEvent {
  final String search;
  ContractWaitingSignEventSearch(this.search);
}

class ContractWaitingSignEventClearSearch extends ContractWaitingSignEvent {}

class ContractWaitingSignEventRefresh extends ContractWaitingSignEvent {}

class ContractWaitingSignEventLoadMore extends ContractWaitingSignEvent {}
