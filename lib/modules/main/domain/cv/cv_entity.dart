import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cv_entity.g.dart';

@JsonSerializable()
class CVEntity extends Equatable {
  final num id;
  final String state;
  final String title;
  final String content;
  final String url;

  const CVEntity(
      {required this.id, required this.state, required this.title, required this.content, required this.url});

  factory CVEntity.fromJson(Map<String, dynamic> json) => _$CVEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CVEntityToJson(this);

  CVEntity copyWith({num? id, String? state, String? title, String? content, String? url}) {
    return CVEntity(
        id: id ?? this.id,
        state: state ?? this.state,
        title: title ?? this.title,
        content: content ?? this.content,
        url: url ?? this.url);
  }

  @override
  List<Object?> get props => [id, state, title, content, url];
}
