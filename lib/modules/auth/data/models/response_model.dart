class AuthSignInResponse {
  final String accessToken;
  final String refreshToken;

  const AuthSignInResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthSignInResponse.fromJson(Map<String, dynamic> json) {
    return AuthSignInResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
