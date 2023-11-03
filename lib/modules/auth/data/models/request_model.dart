class AuthNormalRequest {
  final String username;
  final String password;
  final String deviceToken;

  const AuthNormalRequest({
    required this.username,
    required this.password,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'deviceToken': deviceToken,
      };
}

class AuthNormalRegisterRequest {
  final String username;
  final String password;
  final String type;

  const AuthNormalRegisterRequest({
    required this.username,
    required this.password,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'type': type,
      };
}
