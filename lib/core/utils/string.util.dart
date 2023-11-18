import 'package:intl/intl.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';

class ConvertString {
  String moneyFormat({required String value}) {
    return '${instance.get<NumberFormat>().format(int.parse(value))}VNĐ';
  }

  String timeFormat({required DateTime value}) {
    final epochTime = value.millisecondsSinceEpoch;
    final epochCurrentTime = DateTime.now().millisecondsSinceEpoch;

    final diff = epochCurrentTime - epochTime;

    if (diff < 60000) {
      return instance.get<AppLocalization>().translate('recentAgo') ?? 'Vừa xong';
    } else if (diff < 60000 * 60) {
      return '${(diff / 60000).round()} ${instance.get<AppLocalization>().translate('minuteAgo')}';
    } else if (diff < 60000 * 60 * 24) {
      return '${(diff / (60000 * 60)).round()} ${instance.get<AppLocalization>().translate('hourAgo')}';
    } else if (diff < 60000 * 60 * 24 * 7) {
      return '${(diff / (60000 * 60 * 24)).round()} ${instance.get<AppLocalization>().translate('dayAgo')}';
    } else if (diff < 60000 * 60 * 24 * 30) {
      return '${(diff / (60000 * 60 * 24 * 7)).round()}  ${instance.get<AppLocalization>().translate('weekAgo')}';
    } else if (diff < 60000 * 60 * 24 * 365) {
      return '${(diff / (60000 * 60 * 24 * 30)).round()}  ${instance.get<AppLocalization>().translate('monthAgo')}';
    } else {
      return '${(diff / (60000 * 60 * 24 * 365)).round()}  ${instance.get<AppLocalization>().translate('yearAgo')}';
    }
  }
}
