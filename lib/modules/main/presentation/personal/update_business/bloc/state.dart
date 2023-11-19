import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

class UpdateBusinessState extends Equatable {
  final CompanyEntity companyEntity;
  final File? avatar;
  final File? background;
  final List<String> location;
  final bool listLocationShow;
  const UpdateBusinessState(
      {required this.companyEntity, required this.avatar, required this.background, required this.location, this.listLocationShow = false});

  UpdateBusinessState copyWith({CompanyEntity? companyEntity, File? avatar, File? background, List<String>? location, bool? listLocationShow}) {
    return UpdateBusinessState(
      avatar: avatar ?? this.avatar,
      background: background ?? this.background,
      companyEntity: companyEntity ?? this.companyEntity,
      location: location ?? this.location,
      listLocationShow: listLocationShow ?? this.listLocationShow
    );
  }

  @override
  List<Object?> get props => [companyEntity, avatar, background,location,listLocationShow];
}
