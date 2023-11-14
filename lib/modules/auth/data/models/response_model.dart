class AuthSignInResponse {
  final String accessToken;
  final String refreshToken;
  final String stringeeToken;

  const AuthSignInResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.stringeeToken,
  });

  factory AuthSignInResponse.fromJson(Map<String, dynamic> json) {
    return AuthSignInResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      stringeeToken: json['stringeeToken'],
    );
  }
}
