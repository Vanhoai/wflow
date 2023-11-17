import 'dart:math';

class OtpHelper {
  static String randOtp() {
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    return code.toString();
  }
}
