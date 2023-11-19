import 'package:equatable/equatable.dart';

abstract class ContractHistoryEvent extends Equatable {
  const ContractHistoryEvent();

  @override
  List get props => [];
}

class InitContractHistoryEvent extends ContractHistoryEvent {}

class ScrollContractHistoryEvent extends ContractHistoryEvent {}

class SearchContractHistoryEvent extends ContractHistoryEvent {
  final String txtSearch;

  const SearchContractHistoryEvent({required this.txtSearch});

  @override
  List get props => [txtSearch];
}

class ChangedIconClearSearchContractHistoryEvent extends ContractHistoryEvent {
  final String txtSearch;

  const ChangedIconClearSearchContractHistoryEvent({required this.txtSearch});

  @override
  List get props => [txtSearch];
}
