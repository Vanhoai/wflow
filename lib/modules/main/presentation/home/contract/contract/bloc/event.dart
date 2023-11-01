import 'package:equatable/equatable.dart';

class ContractEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetListContractEvent extends ContractEvent {}

class GetListContractMoreEvent extends ContractEvent {}

class GetListContractSearchEvent extends ContractEvent {
  final String search;

  GetListContractSearchEvent({required this.search});
  @override
  List<Object?> get props => [search];
}
