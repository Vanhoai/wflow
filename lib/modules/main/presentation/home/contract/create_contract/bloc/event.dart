part of 'bloc.dart';

abstract class CreateContractEvent {}

class CreateContractInitEvent extends CreateContractEvent {
  final String contract;

  CreateContractInitEvent({required this.contract});
}

class UpdateTaskCreateContractEvent extends CreateContractEvent {
  final int index;
  final num id;
  final String title;
  final String content;
  final num startTime;
  final num endTime;

  UpdateTaskCreateContractEvent({
    required this.id,
    required this.index,
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
  });
}

class AddTaskCreateContractEvent extends CreateContractEvent {}

class RemoveLastTaskCreateContractEvent extends CreateContractEvent {}

class CreateNewContractEvent extends CreateContractEvent {
  final num contract;
  final String title;
  final String description;
  final num budget;

  CreateNewContractEvent({
    required this.contract,
    required this.title,
    required this.description,
    required this.budget,
  });
}
class AddTaskWithExcel extends CreateContractEvent{
  final num contract;
  final File file;
  AddTaskWithExcel({required this.contract, required this.file});
}
class GetMoney extends CreateContractEvent{

}

class ContractCreatedWorkerSignEvent extends CreateContractEvent {}

class ContractCreatedBusinessSignEvent extends CreateContractEvent {}
