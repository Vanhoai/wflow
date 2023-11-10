import 'package:flutter_config_plus/flutter_config_plus.dart';

class EnvironmentConfiguration {
  static String appName = FlutterConfigPlus.get('APP_NAME');
  static String appVersion = FlutterConfigPlus.get('APP_VERSION');
  static String apiBaseUrl = FlutterConfigPlus.get('API_BASE_URL');
  static String appHeading = FlutterConfigPlus.get('APP_HEADING');
  static String applicationID = FlutterConfigPlus.get('APPLICATION_ID');
  static String accessTokenSecret = FlutterConfigPlus.get('ACCESS_TOKEN_SECRET');
  static String urlSocket = FlutterConfigPlus.get('URL_SOCKET');
}
