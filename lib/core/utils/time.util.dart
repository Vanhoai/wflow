

import 'package:intl/intl.dart';

class Time {
  Time();
  String getHourMinute(String datetime)
  {
    DateTime dateTime = DateTime.parse(datetime);
    return DateFormat('HH:mm').format(dateTime);
  }
  String getDayMonthYear(String datetime)
  {
    DateTime dateTime = DateTime.parse(datetime);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
  String getFullDate(String datetime)
  {
    return '${getDayMonthYear(datetime)} ${getHourMinute(datetime)}';
  }
}