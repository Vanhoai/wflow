import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wflow/modules/main/domain/contract/entities/models/worker.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';

part 'candidate_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CandidateEntity extends Equatable {
  final int id;
  final CVEntity cv;
  final Worker worker;

  const CandidateEntity({required this.id, required this.cv, required this.worker});

  factory CandidateEntity.fromJson(Map<String, dynamic> json) => _$CandidateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateEntityToJson(this);

  CandidateEntity copyWith({int? id, CVEntity? cv, Worker? worker}) {
    return CandidateEntity(
      id: id ?? this.id,
      cv: cv ?? this.cv,
      worker: worker ?? this.worker,
    );
  }

  @override
  List<Object?> get props => [id, cv, worker];
}
