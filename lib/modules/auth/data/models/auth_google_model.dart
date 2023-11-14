class AuthWithGoogleModel {
  final String idToken;
  final String deviceToken;
  final String type;

  const AuthWithGoogleModel({
    required this.idToken,
    required this.deviceToken,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'idToken': idToken,
        'deviceToken': deviceToken,
        'type': type,
      };
}
