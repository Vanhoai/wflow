class AuthNormalRequest {
  final String username;
  final String password;

  const AuthNormalRequest({required this.username, required this.password});
}

class AuthGoogleRequest {
  final String idToken;

  const AuthGoogleRequest({required this.idToken});
}
