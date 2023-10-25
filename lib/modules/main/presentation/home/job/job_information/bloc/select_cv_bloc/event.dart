import 'package:equatable/equatable.dart';

class SelectCVEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyCVEvent extends SelectCVEvent {}

class OnSelectedCVEVent extends SelectCVEvent {
  final num id;

  OnSelectedCVEVent({required this.id});
  @override
  List<Object?> get props => [id];
}
