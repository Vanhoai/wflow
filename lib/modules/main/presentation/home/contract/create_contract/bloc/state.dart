part of 'bloc.dart';

class CreateContractState extends Equatable {
  final List<TaskEntity> tasks;
  final ContractEntity contractEntity;
  final bool initSuccess;
  final String money;
  const CreateContractState({
    required this.tasks,
    required this.contractEntity,
    this.initSuccess = false,
    this.money = ''
  });

  CreateContractState copyWith({
    List<TaskEntity>? tasks,
    ContractEntity? contractEntity,
    bool? initSuccess,
    String? money,
  }) {
    return CreateContractState(
      tasks: tasks ?? this.tasks,
      contractEntity: contractEntity ?? this.contractEntity,
      initSuccess: initSuccess ?? this.initSuccess,
      money: money ?? this.money
    );
  }

  @override
  List<Object?> get props => [tasks, contractEntity,money];
}
