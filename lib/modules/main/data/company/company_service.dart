import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/models/company_model.dart';
import 'package:wflow/modules/main/data/models/post_model.dart';
import 'package:wflow/modules/main/data/models/user_model.dart';

class CompanyPath {
  static const String getCompanyById = '/business/find/';
  static const String myCompany = '/business/my-business';
  static const String myCompanyMember = '/business/members-in-my-business';
  static const String myCompanyJob = '/post/post-in-my-business';
}

abstract class CompanyService {
  Future<CompanyModel> getCompanyById(int id);
  Future<CompanyModel> myCompany();
  Future<List<UserModel>> myCompanyMember(int page, int pageSize);
  Future<List<PostModel>> myCompanyJob(int page, int pageSize);
}

class CompanyServiceImpl implements CompanyService {
  final Agent agent;

  CompanyServiceImpl({required this.agent});

  @override
  Future<CompanyModel> getCompanyById(int id) async {
    try {
      final response = await agent.dio.get(CompanyPath.getCompanyById + id.toString());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return CompanyModel.fromJson(httpResponse.data);
      } else {
        return throw CommonFailure(message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      return throw const ServerFailure();
    }
  }

  @override
  Future<CompanyModel> myCompany() async {
    try {
      final response = await agent.dio.get(CompanyPath.myCompany);
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return CompanyModel.fromJson(httpResponse.data);
      } else {
        return throw CommonFailure(message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      return throw const ServerFailure();
    }
  }

  @override
  Future<List<UserModel>> myCompanyMember(int page, int pageSize) async {
    try {
      final response = await agent.dio.get(CompanyPath.myCompanyMember, queryParameters: {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      });

      HttpResponseWithPagination<dynamic> httpResponse = HttpResponseWithPagination.fromJson(response.data);
      if (response.statusCode == 200) {
        return httpResponse.data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        return throw CommonFailure(message: response.data['message'], statusCode: response.data['statusCode']);
      }
    } catch (e) {
      print(e);
      return throw const ServerFailure();
    }
  }

  @override
  Future<List<PostModel>> myCompanyJob(int page, int pageSize) async {
    try {
      final response = await agent.dio.get(CompanyPath.myCompanyJob, queryParameters: {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      });
      HttpResponseWithPagination<dynamic> httpResponse = HttpResponseWithPagination.fromJson(response.data);
      if (response.statusCode == 200) {
        return httpResponse.data.map((e) => PostModel.fromJson(e)).toList();
      } else {
        return throw CommonFailure(message: response.data['message'], statusCode: response.data['statusCode']);
      }
    } catch (e) {
      print(e);
      return throw const ServerFailure();
    }
  }
}
