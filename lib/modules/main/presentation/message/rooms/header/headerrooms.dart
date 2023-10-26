import 'package:flutter/material.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class HeaderRooms extends StatefulWidget {
  const HeaderRooms({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HeaderRoomsState();
  }
}

class _HeaderRoomsState extends State<HeaderRooms> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AppBarWithLogo(
      actions: [
        const HeaderIcon(
          icon: AppConstants.search,
          // onTap: () => Navigator.of(context).pushNamed(RouteKeys.searchScreen),
        ),
        const SizedBox(width: 12),
        HeaderIcon(
          icon: AppConstants.ic_notification,
          onTap: () => Navigator.of(context).pushNamed(RouteKeys.notificationScreen),
        )
      ],
    );
  }
}
