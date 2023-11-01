import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/contract/entities/models/business.dart';
import 'package:wflow/modules/main/domain/contract/entities/models/worker.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';

part 'contract_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ContractEntity extends Equatable {
  final String cv;
  final num id;
  final String title;
  final String content;
  final dynamic state;
  final String introduction;
  final String salary;
  final bool businessSigned;
  final bool workerSigned;
  final Worker worker;
  final Business business;
  final List<TaskEntity> tasks;

  const ContractEntity({
    required this.cv,
    required this.id,
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
  });

  factory ContractEntity.fromJson(Map<String, dynamic> json) => _$ContractEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ContractEntityToJson(this);

  ContractEntity copyWith({
    String? cv,
    num? id,
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
  }) {
    return ContractEntity(
      cv: cv ?? this.cv,
      id: id ?? this.id,
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
    );
  }

  factory ContractEntity.empty() {
    return const ContractEntity(
      cv: '',
      id: 0,
      title: '',
      content: '',
      state: '',
      introduction: '',
      salary: '',
      businessSigned: false,
      workerSigned: false,
      worker: Worker(
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
      business: Business(
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
      ];
}
