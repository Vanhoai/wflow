class AppConstants {
  // path for icon
  static const String bottomIconPath = "assets/icons/bottom/";
  static const String bottomHome = "${bottomIconPath}ic_home.svg";
  static const String bottomWork = "${bottomIconPath}ic_work.svg";
  static const String bottomMessage = "${bottomIconPath}ic_message.svg";
  static const String bottomExtended = "${bottomIconPath}ic_extended.svg";

  // path for lottie animation
  static const String lottiePath = "assets/anim/";
  static const String lottieLoading = "${lottiePath}animation_loading.json";

  // languages
  static const String pathVN = "assets/languages/vn.json";
  static const String pathEN = "assets/languages/en.json";

  // storage key
  static const String keySecureStorage = "@com.flow";
  static const String accessTokenKey = "$keySecureStorage@ACCESS_TOKEN";
  static const String refreshTokenKey = "$keySecureStorage@REFRESH_TOKEN";
}
