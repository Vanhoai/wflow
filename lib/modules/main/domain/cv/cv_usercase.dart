import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/cv/model/request_model.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/cv/cv_repository.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

abstract class CVUseCase {
  Future<List<CVEntity>> getMyCV();
  Future<Either<UserEntity, Failure>> addCV(RequestAddCV requestAddCV);
}

class CVUseCaseImpl implements CVUseCase {
  final CVRepository cvRepository;

  CVUseCaseImpl({required this.cvRepository});

  @override
  Future<List<CVEntity>> getMyCV() async {
    return await cvRepository.getMyCV();
  }

  @override
  Future<Either<UserEntity, Failure>> addCV(RequestAddCV requestAddCV) async {
    return await cvRepository.addCV(requestAddCV);
  }
}
