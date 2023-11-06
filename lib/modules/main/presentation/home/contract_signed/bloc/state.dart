part of 'bloc.dart';

class ContractSignedState extends Equatable {
  final List<ContractEntity> contracts;
  final bool isLoading;
  final bool isLoadMore;
  final Meta meta;

  const ContractSignedState({
    required this.contracts,
    required this.isLoading,
    required this.isLoadMore,
    required this.meta,
  });

  ContractSignedState copyWith({
    List<ContractEntity>? contracts,
    bool? isLoading,
    bool? isLoadMore,
    Meta? meta,
  }) {
    return ContractSignedState(
      contracts: contracts ?? this.contracts,
      isLoading: isLoading ?? this.isLoading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      meta: meta ?? this.meta,
    );
  }

  @override
  List<Object> get props => [contracts, isLoading, meta];
}
