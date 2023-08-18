class AppConstants {
  // path for icon
  static const String bottomIconPath = "assets/icons/bottom/";
  static const String bottomHome = "${bottomIconPath}ic.home.svg";
  static const String bottomWork = "${bottomIconPath}ic.work.svg";
  static const String bottomMessage = "${bottomIconPath}ic.message.svg";
  static const String bottomExtended = "${bottomIconPath}ic.extended.svg";

  // path for lottie animation
  static const String lottiePath = "assets/anim/";
  static const String lottieLoading = "${lottiePath}animation.loading.json";

  // languages
  static const String pathVN = "assets/languages/vn.json";
  static const String pathEN = "assets/languages/en.json";

  // storage key
  static const String keySecureStorage = "@com.flow";
  static const String accessTokenKey = "$keySecureStorage@ACCESS_TOKEN";
  static const String refreshTokenKey = "$keySecureStorage@REFRESH_TOKEN";
  static const String keySignInWithBiometric = "$keySecureStorage@SIGN_IN_WITH_BIOMETRIC";
  static const String keyPasswordSignInWithBiometric = "$keySecureStorage@PASSWORD_SIGN_IN_WITH_BIOMETRIC";
}
