import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/user/models/request/get_all_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/data/user/models/request/add_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/request/remove_collaborator_model.dart';
import 'package:wflow/modules/main/data/user/models/user_model.dart';

abstract class UserPath {
  static const String myProfile = '/user/my-profile';
  static const String getUsersNotBusiness = '/user/user-not-business';
  static const String addCollaborator = '/business/add-collaborator';
  static const String getAllCollaborator = '/business/members-in-my-business';
  static const String removeCollaborator = '/business/remove-collaborator';
}

abstract class UserService {
  Future<UserModel> myProfile();
  Future<List<UserModel>> getUsersNotBusiness(
      GetUserNotBusinessModel getUserNotBusinessModel);
  Future<bool> addCollaborator(AddCollaboratorModel addCollaboratorModel);
  Future<List<UserModel>> getAllCollaborator(
      GetAllCollaboratorModel getAllCollaboratorModel);
  Future<bool> removeCollaborator(
      RemoveCollaboratorModel removeCollaboratorModel);
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
        return throw CommonFailure(
            message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      return throw const ServerFailure();
    }
  }

  @override
  Future<List<UserModel>> getUsersNotBusiness(
      GetUserNotBusinessModel getUserNotBusinessModel) async {
    try {
      final response = await agent.dio.get(
        UserPath.getUsersNotBusiness,
        queryParameters: {
          'page': getUserNotBusinessModel.page,
          'pageSize': getUserNotBusinessModel.pageSize,
          'search': getUserNotBusinessModel.search,
        },
      );
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode == 200) {
        List<UserModel> users = [];
        httpResponse.data.forEach((user) {
          users.add(UserModel.fromJson(user));
        });

        return users;
      } else {
        return throw CommonFailure(
            message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      if (e is CommonFailure) {
        return throw CommonFailure(
            message: e.message, statusCode: e.statusCode);
      }
      return throw const ServerFailure();
    }
  }

  @override
  Future<bool> addCollaborator(
      AddCollaboratorModel addCollaboratorModel) async {
    try {
      final response = await agent.dio
          .patch(UserPath.addCollaborator, data: addCollaboratorModel.toJson());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode == 200) {
        return true;
      } else {
        return throw CommonFailure(
            message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      return throw const ServerFailure();
    }
  }

  @override
  Future<List<UserModel>> getAllCollaborator(
      GetAllCollaboratorModel getAllCollaboratorModel) async {
    try {
      final response = await agent.dio.get(
        UserPath.getAllCollaborator,
        queryParameters: {
          'page': getAllCollaboratorModel.page,
          'pageSize': getAllCollaboratorModel.pageSize,
        },
      );
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode == 200) {
        List<UserModel> users = [];
        httpResponse.data.forEach((user) {
          users.add(UserModel.fromJson(user));
        });
        return users;
      } else {
        return throw CommonFailure(
            message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      if (e is CommonFailure) {
        return throw CommonFailure(
            message: e.message, statusCode: e.statusCode);
      }
      return throw const ServerFailure();
    }
  }

  @override
  Future<bool> removeCollaborator(
      RemoveCollaboratorModel removeCollaboratorModel) async {
    try {
      final response = await agent.dio.patch(UserPath.removeCollaborator,
          data: removeCollaboratorModel.toJson());
      HttpResponse httpResponse = HttpResponse.fromJson(response.data);
      if (httpResponse.statusCode == 200) {
        return true;
      } else {
        return throw CommonFailure(
            message: httpResponse.message, statusCode: httpResponse.statusCode);
      }
    } catch (e) {
      return throw const ServerFailure();
    }
  }
}
