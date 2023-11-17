import 'package:equatable/equatable.dart';

abstract class ApplyEvent extends Equatable {
  @override
  List get props => [];
}

class InitApplyEvent extends ApplyEvent {}

class ScrollApplyEvent extends ApplyEvent {}

