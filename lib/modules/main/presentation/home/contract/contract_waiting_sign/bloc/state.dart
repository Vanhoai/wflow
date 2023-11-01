part of 'bloc.dart';

class ContractWaitingSignState extends Equatable {
  final List<ContractEntity> contracts;
  final bool isLoading;

  const ContractWaitingSignState({required this.contracts, required this.isLoading});

  ContractWaitingSignState copyWith({
    List<ContractEntity>? contracts,
    bool? isLoading,
  }) {
    return ContractWaitingSignState(
      contracts: contracts ?? this.contracts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [contracts, isLoading];
}
