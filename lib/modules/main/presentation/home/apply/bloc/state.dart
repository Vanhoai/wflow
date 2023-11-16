import 'package:equatable/equatable.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

class ApplyState extends Equatable {
  final List<ContractEntity> applies;
  final Meta meta;
  final bool isLoadMore;

  const ApplyState({
    this.applies = const [],
    this.meta =
        const Meta(currentPage: 1, pageSize: 10, totalPage: 0, totalRecord: 0),
    this.isLoadMore = false,
  });

  ApplyState copyWith({
    List<ContractEntity>? applies,
    String? txtSearch,
    bool? isHiddenClearSearch,
    Meta? meta,
    bool? isLoadMore,
  }) =>
      ApplyState(
          applies: applies ?? this.applies,
          meta: meta ?? this.meta,
          isLoadMore: isLoadMore ?? this.isLoadMore);

  @override
  List get props => [applies, meta, isLoadMore];
}

class LoadMoreApplySate extends ApplyState {}
