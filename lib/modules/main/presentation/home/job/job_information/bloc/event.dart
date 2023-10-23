import 'package:equatable/equatable.dart';

class JobInformationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetJobInformationEvent extends JobInformationEvent {
  final String id;

  GetJobInformationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
