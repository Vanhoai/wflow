import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'request_model.g.dart';
class RequestAddCV {
  final File cv;
  final String title;
  final String content;

  RequestAddCV({required this.cv, required this.title, required this.content});
}

@JsonSerializable()
class RequestDeleteCV {
  final List<String> id;
  RequestDeleteCV({required this.id});
  Map<String, dynamic> toJson() => _$RequestDeleteCVToJson(this);
 
}
