import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class ArgumentsMessage {
  final num? id;
  final UserEntity userEntity;

  ArgumentsMessage({required this.id, required this.userEntity});
}
