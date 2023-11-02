part of 'bloc.dart';

class ContractWaitingSignState extends Equatable {
  final List<ContractEntity> contracts;
  final Meta meta;
  final bool isLoading;

  const ContractWaitingSignState({required this.contracts, required this.isLoading, required this.meta});

  ContractWaitingSignState copyWith({
    List<ContractEntity>? contracts,
    Meta? meta,
    bool? isLoading,
  }) {
    return ContractWaitingSignState(
      contracts: contracts ?? this.contracts,
      meta: meta ?? this.meta,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [contracts, meta, isLoading];
}
