import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';

abstract class SubTopicEvent extends Equatable {
  @override
  List get props => [];
}

class InitSubTopicEvent extends SubTopicEvent {}

class ToggleSubTopicEvent extends SubTopicEvent {
  final CategoryEntity category;

  ToggleSubTopicEvent({required this.category});

  @override
  List get props => [category];
}

class NextSubTopicEvent extends SubTopicEvent {}
