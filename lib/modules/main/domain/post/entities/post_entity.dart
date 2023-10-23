import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_entity.g.dart';

@JsonSerializable()
class PostEntity extends Equatable {
  final num id;
  final String updatedAt;
  final String position;
  final String title;
  final String content;
  final String duration;
  final String salary;
  final num creatorId;
  final String creatorName;
  final String creatorAvatar;
  final String companyName;
  final String companyLogo;
  final List<String> skills;
  final List<String> tasks;

  const PostEntity({
    required this.id,
    required this.updatedAt,
    required this.position,
    required this.title,
    required this.content,
    required this.duration,
    required this.salary,
    required this.creatorId,
    required this.creatorName,
    required this.creatorAvatar,
    required this.companyName,
    required this.companyLogo,
    required this.skills,
    required this.tasks,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostEntityToJson(this);

  factory PostEntity.empty() => const PostEntity(
      id: 0,
      updatedAt: '',
      position: '',
      title: 'title',
      content: 'content',
      duration: 'duration',
      salary: 'salary',
      creatorId: 1,
      creatorName: 'creatorName',
      creatorAvatar: 'creatorAvatar',
      companyName: 'companyName',
      companyLogo: 'companyLogo',
      skills: [],
      tasks: []);

  PostEntity copyWith({
    num? id,
    String? updatedAt,
    String? position,
    String? title,
    String? content,
    String? duration,
    String? salary,
    num? creatorId,
    String? creatorName,
    String? creatorAvatar,
    String? companyName,
    String? companyLogo,
    List<String>? skills,
    List<String>? tasks,
  }) {
    return PostEntity(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      position: position ?? this.position,
      title: title ?? this.title,
      content: content ?? this.content,
      duration: duration ?? this.duration,
      salary: salary ?? this.salary,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      creatorAvatar: creatorAvatar ?? this.creatorAvatar,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      skills: skills ?? this.skills,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [
        id,
        updatedAt,
        position,
        title,
        content,
        duration,
        salary,
        creatorId,
        creatorName,
        creatorAvatar,
        companyName,
        companyLogo,
        skills,
        tasks,
      ];
}
