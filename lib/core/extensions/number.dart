import 'package:intl/intl.dart';

extension Format on num {
  String toVND() {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'VND', decimalDigits: 0).format(this);
  }
}
