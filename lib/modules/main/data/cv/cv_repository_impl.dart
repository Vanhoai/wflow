import 'package:dartz/dartz.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/modules/main/data/cv/cv_services.dart';
import 'package:wflow/modules/main/data/cv/model/request_model.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/cv/cv_repository.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class CVRepositoryImpl implements CVRepository {
  final CVService cvService;

  CVRepositoryImpl({required this.cvService});

  @override
  Future<List<CVEntity>> getMyCV() async {
    try {
      final cvs = await cvService.getMyCV();
      return cvs;
    } catch (exception) {
      return [];
    }
  }

  @override
  Future<Either<UserEntity, Failure>> addCV(RequestAddCV requestAddCV) async {
    try {
      final cv = await cvService.addCV(requestAddCV);
      return Left(cv);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
  
  @override
  Future<Either<String, Failure>> deleteCV(RequestDeleteCV requestDeleteCV) async {
     try {
      final cv = await cvService.deleteCV(requestDeleteCV);
      return Left(cv);
    } catch (exception) {
      return const Right(ServerFailure());
    }
  }
}
