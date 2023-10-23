import 'package:dio/dio.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';

import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/utils/utils.dart';

class Agent {
  final Dio dio = Dio();
  final SecureStorage secureStorage;

  Agent({required this.secureStorage}) {
    dio.options = generateOptions();

    InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper(onRequest: (options, handler) async {
      final accessToken = instance.get<AppBloc>().state.authEntity.accessToken;
      options.headers = {
        ...options.headers,
        'Authorization': 'Bearer $accessToken',
      };

      return handler.next(options);
    }, onError: (DioException exception, handler) async {
      if (exception.response?.statusCode == 401) {
        await refreshToken();
        return handler.resolve(await retry(exception.requestOptions));
      }
      return handler.next(exception);
    });

    dio.interceptors.add(interceptorsWrapper);
  }

  BaseOptions generateOptions() {
    print(EnvironmentConfiguration.apiBaseUrl);
    BaseOptions opts = BaseOptions();
    opts.baseUrl = EnvironmentConfiguration.apiBaseUrl;
    opts.contentType = Headers.jsonContentType;
    opts.connectTimeout = const Duration(seconds: 4);
    opts.receiveTimeout = const Duration(seconds: 4);
    opts.sendTimeout = const Duration(seconds: 4);
    return opts;
  }

  Future<void> refreshToken() async {
    final refreshToken = await secureStorage.read(AppConstants.refreshTokenKey);
    final response = await dio.post('/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 201) {
      // successfully got the new access token
    } else {
      // refresh token is wrong so log out user.
      secureStorage.clear();
    }
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
