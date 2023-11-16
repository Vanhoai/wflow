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
  final String introduction;
  ApplyPostEvent({required this.post, required this.cv, required this.introduction});
  @override
  List<Object?> get props => [post, cv, introduction];
}
