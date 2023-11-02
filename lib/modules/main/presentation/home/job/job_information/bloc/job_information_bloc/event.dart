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

class ApplyPostEvent extends JobInformationEvent {
  final num post;
  final num cv;

  ApplyPostEvent({required this.post, required this.cv});
  @override
  List<Object?> get props => [post, cv];
}
