import 'package:equatable/equatable.dart';

class CVEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyCVEvent extends CVEvent {}

class OnSelectedCVEVent extends CVEvent {
  final bool state;
  final num id;

  OnSelectedCVEVent({required this.state, required this.id});

  @override
  List<Object?> get props => [state, id];
}
class RemoveCV extends CVEvent{
  
}