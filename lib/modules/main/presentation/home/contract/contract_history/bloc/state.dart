import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

class ContractHistoryState extends Equatable {
  final List<ContractEntity> contractHistories;
  final Meta meta;
  final String txtSearch;
  final bool isHiddenClearIconSearch;

  const ContractHistoryState({
    this.contractHistories = const [],
    this.meta = const Meta(currentPage: 1, totalPage: 0, totalRecord: 0, pageSize: 10),
    this.txtSearch = '',
    this.isHiddenClearIconSearch = true,
  });

  ContractHistoryState copyWith({
    List<ContractEntity>? contractHistories,
    Meta? meta,
    String? txtSearch,
    bool? isHiddenClearIconSearch,
  }) =>
      ContractHistoryState(
          contractHistories: contractHistories ?? this.contractHistories,
          meta: meta ?? this.meta,
          txtSearch: txtSearch ?? this.txtSearch,
          isHiddenClearIconSearch: isHiddenClearIconSearch ?? this.isHiddenClearIconSearch);

  @override
  List get props => [contractHistories, meta, txtSearch, isHiddenClearIconSearch];
}
