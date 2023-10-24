class RefreshToken {
  final String accessToken;
  final String refreshToken;

  RefreshToken({required this.accessToken, required this.refreshToken});

  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
