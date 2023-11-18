import 'package:intl/intl.dart';
import 'package:wflow/common/injection.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConvertString {
  String moneyFormat({required String value}){
    return '${instance.get<NumberFormat>().format(int.parse(value))}VNĐ';
  }
  String timeFormat ({required DateTime value}){
    return timeago.format(value);
  }
}  