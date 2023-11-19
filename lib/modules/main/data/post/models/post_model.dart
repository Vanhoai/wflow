import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends BaseEntity with EquatableMixin {
  @JsonKey(name: 'position', defaultValue: '')
  final String position;

  @JsonKey(name: 'title', defaultValue: '')
  final String title;

  @JsonKey(name: 'content', defaultValue: '')
  final String content;

  @JsonKey(name: 'duration', defaultValue: '')
  final String duration;

  @JsonKey(name: 'salary', defaultValue: '')
  final String salary;

  @JsonKey(name: 'numberApplied', defaultValue: 0)
  final num numberApplied;

  @JsonKey(name: 'business', defaultValue: 0)
  final num business;

  @JsonKey(name: 'creatorId', defaultValue: 0)
  final num creatorId;

  @JsonKey(name: 'creatorName', defaultValue: '')
  final String creatorName;

  @JsonKey(name: 'creatorAvatar', defaultValue: '')
  final String creatorAvatar;

  @JsonKey(name: 'companyName', defaultValue: '')
  final String companyName;

  @JsonKey(name: 'companyLogo', defaultValue: '')
  final String companyLogo;

  @JsonKey(name: 'skills', defaultValue: [])
  final List<String> skills;

  @JsonKey(name: 'tasks', defaultValue: [])
  final List<String> tasks;

  @JsonKey(name: 'paymentAvailable', defaultValue: false)
  final bool paymentAvailable;

  const PostModel({
    required super.id,
    required super.updatedAt,
    required super.createdAt,
    required super.deletedAt,
    required this.position,
    required this.title,
    required this.content,
    required this.duration,
    required this.salary,
    required this.business,
    required this.creatorId,
    required this.creatorName,
    required this.creatorAvatar,
    required this.companyName,
    required this.companyLogo,
    required this.skills,
    required this.tasks,
    required this.numberApplied,
    required this.paymentAvailable,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  factory PostModel.createEmpty() => PostModel(
        id: 0,
        updatedAt: null,
        createdAt: DateTime.now(),
        deletedAt: null,
        position: '',
        title: '',
        content: '',
        duration: '',
        salary: '',
        business: 0,
        creatorId: 0,
        creatorName: '',
        creatorAvatar: '',
        companyName: '',
        companyLogo: '',
        skills: [],
        tasks: [],
        numberApplied: 0,
        paymentAvailable: false,
      );

  PostModel copyWith({
    String? position,
    String? title,
    String? content,
    String? duration,
    String? salary,
    num? business,
    num? creatorId,
    String? creatorName,
    String? creatorAvatar,
    String? companyName,
    String? companyLogo,
    List<String>? skills,
    List<String>? tasks,
    num? numberApplied,
    bool? paymentAvailable,
  }) {
    return PostModel(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      position: position ?? this.position,
      title: title ?? this.title,
      content: content ?? this.content,
      duration: duration ?? this.duration,
      salary: salary ?? this.salary,
      business: business ?? this.business,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      creatorAvatar: creatorAvatar ?? this.creatorAvatar,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      skills: skills ?? this.skills,
      tasks: tasks ?? this.tasks,
      numberApplied: numberApplied ?? this.numberApplied,
      paymentAvailable: paymentAvailable ?? this.paymentAvailable,
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
        business,
        creatorId,
        creatorName,
        creatorAvatar,
        companyName,
        companyLogo,
        skills,
        tasks,
        numberApplied,
        paymentAvailable,
      ];
}
