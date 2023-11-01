import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/meta/meta_model.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

class ContractListState extends Equatable {
  final bool isLoading;
  final Meta meta;
  final String search;

  const ContractListState({
    this.isLoading = false,
    this.meta = const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
    this.search = '',
  });

  ContractListState copyWith({bool? isLoading}) {
    return ContractListState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading, meta, search];
}

class GetContractListSuccessState extends ContractListState {
  final List<ContractEntity> contractEntities;
  final bool loadMore;

  const GetContractListSuccessState(
      {required super.isLoading,
      required super.meta,
      required super.search,
      required this.contractEntities,
      required this.loadMore});
  @override
  GetContractListSuccessState copyWith({
    List<ContractEntity>? contractEntities,
    bool? loadMore,
    bool? isLoading,
    Meta? meta,
    String? search,
  }) {
    return GetContractListSuccessState(
        contractEntities: contractEntities ?? this.contractEntities,
        loadMore: loadMore ?? this.loadMore,
        isLoading: isLoading ?? super.isLoading,
        meta: meta ?? super.meta,
        search: search ?? super.search);
  }

  @override
  List<Object?> get props => [isLoading, meta, search, contractEntities, loadMore];
}
