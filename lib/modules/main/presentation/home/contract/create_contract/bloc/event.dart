part of 'bloc.dart';

abstract class CreateContractEvent {}

class CreateContractInitEvent extends CreateContractEvent {}

class UpdateTaskCreateContractEvent extends CreateContractEvent {
  final int index;
  final String title;
  final String content;
  final num startTime;
  final num endTime;

  UpdateTaskCreateContractEvent({
    required this.index,
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
  });
}

class AddTaskCreateContractEvent extends CreateContractEvent {}

class RemoveLastTaskCreateContractEvent extends CreateContractEvent {}
