import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/user/models/user_model.dart';

abstract class UserPath {
  static const String myProfile = '/user/my-profile';
}

abstract class UserService {
  Future<UserModel> myProfile();
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
}
