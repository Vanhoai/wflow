class AppConstants {
  // path for icon
  static const String iconPath = "assets/icons/";

  // path for lottie animation
  static const String lottiePath = "assets/anim/";
  static const String lottieLoading = "${lottiePath}animation_loading.json";

  // languages
  static const String pathVN = "assets/languages/vn.json";
  static const String pathEN = "assets/languages/en.json";

  // storage key
  static const String keySecureStorage = "@app";
  static const String accessTokenKey = "$keySecureStorage@ACCESS_TOKEN";
  static const String refreshTokenKey = "$keySecureStorage@REFRESH_TOKEN";
}
