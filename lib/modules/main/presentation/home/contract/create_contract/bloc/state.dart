part of 'bloc.dart';

class CreateContractState extends Equatable {
  final List<TaskCreateContractModel> tasks;

  const CreateContractState({this.tasks = const []});

  CreateContractState copyWith({
    List<TaskCreateContractModel>? tasks,
  }) {
    return CreateContractState(
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [tasks];
}
