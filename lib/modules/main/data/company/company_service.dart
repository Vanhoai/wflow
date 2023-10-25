import 'package:dartz/dartz.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/company/models/response/company_model.dart';

class CompanyPath {
  static const String getCompanyById = '/business/find/';
  static const String myCompany = '/business/my-business';
}

abstract class CompanyService {
  Future<Either<Failure, CompanyModel>> getCompanyById(int id);
  Future<Either<Failure, CompanyModel>> myCompany();
}

class CompanyServiceImpl implements CompanyService {
  final Agent agent;

  CompanyServiceImpl({required this.agent});

  @override
  Future<Either<Failure, CompanyModel>> getCompanyById(int id) async {
    try {
      final response = await agent.dio.get(CompanyPath.getCompanyById + id.toString());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(CompanyModel.fromJson(httpResponse.data));
      } else {
        return Left(CommonFailure(message: httpResponse.message));
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CompanyModel>> myCompany() async {
    try {
      final response = await agent.dio.get(CompanyPath.myCompany);
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(CompanyModel.fromJson(httpResponse.data));
      } else {
        return Left(CommonFailure(message: httpResponse.message));
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
