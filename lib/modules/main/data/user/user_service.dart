import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/user_model.dart';

abstract class UserPath {
  static const String myProfile = '/user/my-profile';
  static const String getUsersNotBusiness = '/user/user-not-business';
  static const String addCollaborator = '/business/add-collaborator';
  static const String getAllCollaborator = '/business/members-in-my-business';
  static const String removeCollaborator = '/business/remove-collaborator';
  static String findUserByID(String id) => '/user/find/$id';
}

abstract class UserService {
  Future<UserModel> myProfile();
  Future<HttpResponseWithPagination<UserModel>> getUsersNotBusiness(
      {required GetUserNotBusinessModel getUserNotBusinessModel});
  Future<String> addCollaborator(AddCollaboratorModel addCollaboratorModel);
  Future<HttpResponseWithPagination<UserModel>> getAllCollaborator(GetAllCollaboratorModel getAllCollaboratorModel);
  Future<String> removeCollaborator(RemoveCollaboratorModel removeCollaboratorModel);
  Future<UserModel> findUserByID({required String id});
}

class UserServiceImpl implements UserService {
  final Agent agent;

  UserServiceImpl({required this.agent});

  @override
  Future<UserModel> myProfile() async {
    try {
      final response = await agent.dio.get(UserPath.myProfile);
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode == 200) {
        return UserModel.fromJson(httpResponse.data);
      } else {
        return throw CommonFailure(message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      return throw const ServerFailure();
    }
  }

  @override
  Future<HttpResponseWithPagination<UserModel>> getUsersNotBusiness({
    required GetUserNotBusinessModel getUserNotBusinessModel,
  }) async {
    try {
      final response = await agent.dio.get(
        UserPath.getUsersNotBusiness,
        queryParameters: {
          'page': getUserNotBusinessModel.page,
          'pageSize': getUserNotBusinessModel.pageSize,
          'search': getUserNotBusinessModel.search,
        },
      );

      HttpResponseWithPagination httpResponse = HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<UserModel> users = [];
      for (var user in httpResponse.data) {
        users.add(UserModel.fromJson(user));
      }

      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: users,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> addCollaborator(AddCollaboratorModel addCollaboratorModel) async {
    try {
      final response = await agent.dio.patch(UserPath.addCollaborator, data: addCollaboratorModel.toJson());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.data;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<HttpResponseWithPagination<UserModel>> getAllCollaborator(
    GetAllCollaboratorModel getAllCollaboratorModel,
  ) async {
    try {
      final response = await agent.dio.get(
        UserPath.getAllCollaborator,
        queryParameters: {
          'page': getAllCollaboratorModel.page,
          'pageSize': getAllCollaboratorModel.pageSize,
        },
      );

      HttpResponseWithPagination httpResponse = HttpResponseWithPagination.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      List<UserModel> users = [];
      for (var user in httpResponse.data) {
        users.add(UserModel.fromJson(user));
      }

      return HttpResponseWithPagination(
        statusCode: httpResponse.statusCode,
        message: httpResponse.message,
        meta: httpResponse.meta,
        data: users,
      );
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<String> removeCollaborator(RemoveCollaboratorModel removeCollaboratorModel) async {
    try {
      final response = await agent.dio.patch(UserPath.removeCollaborator, data: removeCollaboratorModel.toJson());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode != 200) {
        throw ServerException(message: httpResponse.message);
      }

      return httpResponse.data;
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }

  @override
  Future<UserModel> findUserByID({required String id}) async {
    try {
      final response = await agent.dio.get(UserPath.findUserByID(id));
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      if (httpResponse.statusCode != 200) {
        throw CommonFailure(message: httpResponse.message, statusCode: httpResponse.statusCode);
      }

      return UserModel.fromJson(httpResponse.data);
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}
