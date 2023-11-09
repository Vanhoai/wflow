import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/core/models/models.dart';
import 'package:wflow/core/routes/keys.dart';
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
      return handler.next(exception);
    }, onResponse: (Response<dynamic> response, handler) async {
      print('Response: ${response.data}');

      if (response.statusCode! >= 500) {
        exitApp('Some thing error, please try again later');
      }

      HttpResponse httpResponse = HttpResponse.fromJson(response.data);

      // check status 401 => refresh token
      if (httpResponse.statusCode == 401) {
        print('Refresh token');

        final String? accessToken = await refreshToken();

        print('Access token: $accessToken');
        if (accessToken != null && accessToken.isNotEmpty) {
          final options = response.requestOptions;
          options.headers = {
            ...options.headers,
            'Authorization': 'Bearer $accessToken',
          };

          print('Retry request: ${options.path}');

          return handler.resolve(await retry(options));
        } else {
          print('Exit app: ${httpResponse.message}');

          exitApp(httpResponse.message);
        }
      } else if (httpResponse.statusCode == 402) {
        exitApp(httpResponse.message);
      }

      return handler.next(response);
    });

    dio.interceptors.add(interceptorsWrapper);
  }

  BaseOptions generateOptions() {
    BaseOptions opts = BaseOptions();
    opts.baseUrl = EnvironmentConfiguration.apiBaseUrl;
    opts.contentType = Headers.jsonContentType;
    opts.connectTimeout = const Duration(seconds: 30);
    opts.receiveTimeout = const Duration(seconds: 30);
    opts.sendTimeout = const Duration(seconds: 30);
    return opts;
  }

  Future<String?> refreshToken() async {
    final refreshToken = instance.get<AppBloc>().state.authEntity.refreshToken;
    final response = await dio.post('/auth/refresh-token', data: {'refreshToken': refreshToken});
    final httpResponse = HttpResponse.fromJson(response.data);
    if (httpResponse.statusCode == 200) {
      RefreshToken dataRefresh = RefreshToken.fromJson(httpResponse.data);

      instance
          .get<AppBloc>()
          .add(RefreshTokenEvent(accessToken: dataRefresh.accessToken, refreshToken: dataRefresh.refreshToken));

      return dataRefresh.accessToken;
    } else {
      instance.get<NavigationService>().pushNamedAndRemoveUntil(RouteKeys.signInScreen);
    }
    return null;
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

  void exitApp(String message) {
    showCupertinoDialog(
      context: instance.get<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Notification', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(message),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                instance.get<NavigationService>().pushNamedAndRemoveUntil(RouteKeys.signInScreen);
              },
            ),
          ],
        );
      },
    );
  }
}
