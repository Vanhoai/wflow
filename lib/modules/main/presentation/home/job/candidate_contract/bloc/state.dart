import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/contract/contract_entity.dart';

class CandidateDetailState extends Equatable {
  final bool isLoading;
  const CandidateDetailState({this.isLoading = false});

  CandidateDetailState copyWith({bool? isLoading}) {
    return CandidateDetailState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}

class GetCandidateDetailFailureState extends CandidateDetailState {
  const GetCandidateDetailFailureState({super.isLoading = false});
}

class GetCandidateDetailSuccessState extends CandidateDetailState {
  final ContractEntity contractEntity;
  const GetCandidateDetailSuccessState({required this.contractEntity, required super.isLoading});
  @override
  GetCandidateDetailSuccessState copyWith({ContractEntity? contractEntity, bool? isLoading}) {
    return GetCandidateDetailSuccessState(
        contractEntity: contractEntity ?? this.contractEntity, isLoading: isLoading ?? super.isLoading);
  }

  @override
  List<Object?> get props => [contractEntity, isLoading];
}
