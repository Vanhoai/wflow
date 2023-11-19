import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class DetailUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailUserSuccess extends DetailUserState {
  final UserEntity userEntity;

  GetDetailUserSuccess({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}
