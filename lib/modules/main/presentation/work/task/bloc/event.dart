import 'package:equatable/equatable.dart';

class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class InitEvent extends TaskEvent {}

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

class RatingEvent extends TaskEvent {
  final num star;
  final String description;
  final num businessID;
  final num userID;

  const RatingEvent({required this.star, required this.description, required this.businessID, required this.userID});

  @override
  List<Object?> get props => [star, description, businessID, userID];
}
