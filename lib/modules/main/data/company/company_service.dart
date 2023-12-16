import 'package:dio/dio.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/company/company_model.dart';
import 'package:wflow/modules/main/data/company/request/update_business_rqst.dart';
import 'package:wflow/modules/main/data/post/models/post_model.dart';
import 'package:wflow/modules/main/data/user/models/user_model.dart';

class CompanyPath {
  static const String getCompanyById = '/business/find/';
  static const String myCompany = '/business/my-business';
  static const String myCompanyMember = '/business/members-in-my-business';
  static myCompanyJob({required String id}) => '/post/post-in-my-business/$id';
  static const String upgradeBusiness = '/user/upgrade-to-business';
  static findCompany({required String id}) => '/business/find/$id';
  static const String updateBusiness = '/business/update-business';
}

abstract class CompanyService {
  Future<CompanyModel> getCompanyById(int id);
  Future<CompanyModel> myCompany();
  Future<List<UserModel>> myCompanyMember(int page, int pageSize);
  Future<List<PostModel>> myCompanyJob(int page, int pageSize, String id);
  Future<String> upgradeBusiness({required UpgradeBusinessRequest request});
  Future<CompanyModel> findCompany({required String id});
  Future<String> updateBusiness({required RequestUpdateBusiness request});
}

class CompanyServiceImpl implements CompanyService {
  final Agent agent;
  CompanyServiceImpl({required this.agent});

  @override
  Future<CompanyModel> getCompanyById(int id) async {
    try {
      final response = await agent.dio.get(CompanyPath.getCompanyById + id.toString());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return CompanyModel.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<CompanyModel> myCompany() async {
    try {
      final response = await agent.dio.get(CompanyPath.myCompany);
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return CompanyModel.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
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
      if (response.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return httpResponse.data.map((e) => UserModel.fromJson(e)).toList();
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<List<PostModel>> myCompanyJob(int page, int pageSize, String id) async {
    try {
      final response = await agent.dio.get(CompanyPath.myCompanyJob(id: id), queryParameters: {
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      });

      HttpResponseWithPagination<dynamic> httpResponse = HttpResponseWithPagination.fromJson(response.data);
      if (response.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return httpResponse.data.map((e) => PostModel.fromJson(e)).toList();
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<String> upgradeBusiness({required UpgradeBusinessRequest request}) async {
    try {
      final response = await agent.dio.put(CompanyPath.upgradeBusiness, data: request.toJson());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return httpResponse.data;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<CompanyModel> findCompany({required String id}) async {
    try {
      final response = await agent.dio.get(CompanyPath.findCompany(id: id));
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (response.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return CompanyModel.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  @override
  Future<String> updateBusiness({required RequestUpdateBusiness request}) async {
    try {
      var formData = FormData.fromMap({
        'logo': request.logo != null ? await MultipartFile.fromFile((request.logo!.path)) : null,
        'background': request.background != null ? await MultipartFile.fromFile(request.background!.path) : null,
        'overview': request.companyEntity.overview,
        'address': request.companyEntity.address,
        'longitude': request.companyEntity.longitude,
        'latitude': request.companyEntity.latitude,
        'id': request.companyEntity.id
      });
      final response = await agent.dio.put(
        CompanyPath.updateBusiness,
        data: formData,
      );

      final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(httpResponse.message);
      }

      return httpResponse.data;
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }
}
