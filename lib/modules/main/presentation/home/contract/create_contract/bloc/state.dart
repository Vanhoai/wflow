part of 'bloc.dart';

class CreateContractState extends Equatable {
  final List<TaskEntity> tasks;
  final ContractEntity contractEntity;
  final bool initSuccess;

  const CreateContractState({
    required this.tasks,
    required this.contractEntity,
    this.initSuccess = false,
  });

  CreateContractState copyWith({
    List<TaskEntity>? tasks,
    ContractEntity? contractEntity,
    bool? initSuccess,
  }) {
    return CreateContractState(
      tasks: tasks ?? this.tasks,
      contractEntity: contractEntity ?? this.contractEntity,
      initSuccess: initSuccess ?? this.initSuccess,
    );
  }

  @override
  List<Object?> get props => [tasks, contractEntity];
}
