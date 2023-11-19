import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/base/base_entity.dart';
import 'package:wflow/modules/main/domain/contract/entities/models/business.dart';
import 'package:wflow/modules/main/domain/contract/entities/models/worker.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

part 'contract_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ContractEntity extends BaseEntity with EquatableMixin {
  final String cv;
  final String title;
  final String content;
  final dynamic state;
  final String introduction;
  final String salary;
  final bool businessSigned;
  final bool workerSigned;
  final Worker worker;
  final Business business;
  final num progress;
  final List<TaskEntity> tasks;
  final String position;

  const ContractEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
    required this.cv,
    required this.title,
    required this.content,
    required this.state,
    required this.introduction,
    required this.salary,
    required this.businessSigned,
    required this.workerSigned,
    required this.worker,
    required this.business,
    required this.tasks,
    required this.progress,
    required this.position,
  });

  factory ContractEntity.fromJson(Map<String, dynamic> json) => _$ContractEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContractEntityToJson(this);

  ContractEntity copyWith({
    String? cv,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? title,
    String? content,
    dynamic state,
    String? introduction,
    String? salary,
    bool? workerSigned,
    bool? businessSigned,
    Worker? worker,
    Business? business,
    List<TaskEntity>? tasks,
    num? progress,
    String? position,
  }) {
    return ContractEntity(
      cv: cv ?? this.cv,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      content: content ?? this.content,
      state: state ?? this.state,
      introduction: introduction ?? this.introduction,
      salary: salary ?? this.salary,
      businessSigned: businessSigned ?? this.businessSigned,
      workerSigned: workerSigned ?? this.workerSigned,
      worker: worker ?? this.worker,
      business: business ?? this.business,
      tasks: tasks ?? this.tasks,
      progress: progress ?? this.progress,
      position: position ?? this.position,
    );
  }

  factory ContractEntity.empty() {
    return ContractEntity(
      cv: '',
      id: 0,
      progress: 0,
      createdAt: DateTime.now(),
      deletedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: 'ESM Project',
      content: '',
      state: '',
      introduction: '',
      salary: '0',
      businessSigned: false,
      workerSigned: false,
      position: '',
      worker: const Worker(
        id: 0,
        name: '',
        role: 0,
        age: 0,
        address: '',
        email: '',
        phone: '',
        isVerify: false,
        avatar: '',
        business: 0,
        createdAt: '',
        dob: '',
        identifyCode: '',
      ),
      business: const Business(
        id: 0,
        email: '',
        phone: '',
        name: '',
        logo: '',
        address: '',
        totalCollaborators: 0,
        totalContracts: 0,
        totalPosts: 0,
        background: '',
        createdAt: '',
        deletedAt: '',
        latitude: 0,
        longitude: 0,
        overview: '',
        state: '',
        updatedAt: '',
      ),
      tasks: [],
    );
  }

  @override
  List<Object?> get props => [
        cv,
        id,
        title,
        content,
        state,
        introduction,
        salary,
        businessSigned,
        workerSigned,
        worker,
        business,
        tasks,
        progress,
        position,
      ];
}
