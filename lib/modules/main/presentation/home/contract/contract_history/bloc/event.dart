import 'package:equatable/equatable.dart';

abstract class ContractHistoryEvent extends Equatable {
  const ContractHistoryEvent();

  @override
  List get props => [];
}

class InitContractHistoryEvent extends ContractHistoryEvent {}

class ScrollContractHistoryEvent extends ContractHistoryEvent {}
