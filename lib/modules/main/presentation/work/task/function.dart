import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/enum/task_enum.dart';

Widget iconStatus(TaskStatus status) {
  switch (status) {
    case TaskStatus.Accepted:
      return Padding(padding: const EdgeInsets.all(2), child: SvgPicture.asset(AppConstants.checkOutLine));
    case TaskStatus.Done:
      return Padding(padding: const EdgeInsets.all(0), child: SvgPicture.asset(AppConstants.warning));
    case TaskStatus.Reject:
      return Padding(padding: const EdgeInsets.all(4), child: SvgPicture.asset(AppConstants.danger));
    default:
      return Padding(padding: const EdgeInsets.all(2), child: SvgPicture.asset(AppConstants.checkOutLine));
  }
}

Color colorStatus(TaskStatus status) {
  switch (status) {
    case TaskStatus.Accepted:
      return Colors.green;
    case TaskStatus.Done:
      return Colors.orange;
    case TaskStatus.Reject:
      return Colors.red;
    default:
      return Colors.white;
  }
}
