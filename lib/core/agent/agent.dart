import 'package:dio/dio.dart';

import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/utils/utils.dart';

class Agent {
  final Dio dio = Dio();
  final SecureStorage secureStorage;

  Agent({required this.secureStorage}) {
    dio.options = generateOptions();

    InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper(onRequest: (options, handler) async {
      final accessToken = await secureStorage.read("access_token");
      options.headers = {
        ...options.headers,
        "Authorization": "Bearer $accessToken",
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
    BaseOptions opts = BaseOptions();
    opts.baseUrl = EnvironmentConfiguration.apiBaseUrl;
    opts.contentType = Headers.jsonContentType;
    opts.connectTimeout = const Duration(seconds: 10);
    opts.receiveTimeout = const Duration(seconds: 10);
    opts.sendTimeout = const Duration(seconds: 10);
    return opts;
  }

  Future<void> refreshToken() async {
    final refreshToken = await secureStorage.read('refresh_token');
    final response = await dio.post('/auth/refresh', data: {'refresh_token': refreshToken});

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
