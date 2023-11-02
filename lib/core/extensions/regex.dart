extension Regex on String {
  bool isEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool isPassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(this);
  }

  bool isPhoneNumber() {
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);
  }

  bool isName() {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(this);
  }

  bool isNumber() {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }
}
