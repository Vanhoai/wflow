import 'package:flutter/cupertino.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/common/navigation.dart';

class AlertUtils {
  static void showMessage(String? title, String? content, {Function? callback}) {
    showCupertinoDialog(
      context: instance.get<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title ?? instance.get<AppLocalization>().translate('notification') ?? 'Notification',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          content: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(content ??
                instance.get<AppLocalization>().translate('pleaseTryAgain') ??
                'Something went wrong, please try again later.'),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (callback != null) {
                  callback();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
