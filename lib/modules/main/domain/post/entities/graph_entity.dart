

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'graph_entity.g.dart';
@JsonSerializable()
class GraphEntity extends Equatable {
  final String tag;
  final String count;

  const GraphEntity({required this.tag, required this.count});

  factory GraphEntity.fromJson(Map<String, dynamic> json) => _$GraphEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GraphEntityToJson(this);


  @override
  List<Object?> get props => [tag, count];
  
}