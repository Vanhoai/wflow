import 'package:equatable/equatable.dart';

class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class GetTaskEvent extends TaskEvent {
  final num idContract;

  const GetTaskEvent({required this.idContract});
  @override
  List<Object?> get props => [idContract];
}

class UpdateTaskEvent extends TaskEvent {
  final num id;
  final String status;
  const UpdateTaskEvent({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}

class CheckContractAndTransfer extends TaskEvent {
  final num id;

  const CheckContractAndTransfer({required this.id});
  @override
  List<Object?> get props => [id];
}

class CleanEvent extends TaskEvent {}
