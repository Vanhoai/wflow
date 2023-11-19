class StringsUtil {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static bool isEmail(String email) => RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);

  static bool isPhoneNumber(String phone) => RegExp(r'^[0-9]{10,11}$').hasMatch(phone);

  static bool isPassword(String password) =>
      RegExp(r'^[a-zA-Z0-9@!#$%^&*()_+`~\-=\[\]\\{}|;’:\",./<>?]{8,}$').hasMatch(password);

  static bool isComparePassword(String password, String rePassword) => password == rePassword;

  static String parseMoney(String money) {
    if (money.isEmpty) return '0';
    return money.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
  }
}
