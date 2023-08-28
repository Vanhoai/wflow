class AppConstants {
  // path for icon
  static const String bottomIconPath = "assets/icons/bottom/";
  static const String bottomHome = "${bottomIconPath}ic.home.svg";
  static const String bottomWork = "${bottomIconPath}ic.work.svg";
  static const String bottomMessage = "${bottomIconPath}ic.message.svg";
  static const String bottomExtended = "${bottomIconPath}ic.extended.svg";
  //path for common icon
  static const String commonIconPath = "assets/icons/common/";
  static const String app = "${commonIconPath}ic.app.svg";
  static const String showPass = "${commonIconPath}ic.showpass.svg";
  static const String hidePass = "${commonIconPath}ic.hidepass.svg";
  static const String bionic = "${commonIconPath}ic.bionic.svg";
  static const String checkFill = "${commonIconPath}ic.checkfill.svg";
  static const String checkOutLine = "${commonIconPath}ic.checkoutline.svg";
  static const String email = "${commonIconPath}ic.email.svg";
  static const String google = "${commonIconPath}ic.google.svg";
  static const String lock = "${commonIconPath}ic.lock.svg";
  static const String phone = "${commonIconPath}ic.phone.svg";
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
