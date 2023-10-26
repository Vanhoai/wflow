import 'package:flutter/material.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class HeaderBarWidget extends StatefulWidget {
  const HeaderBarWidget({super.key});

  @override
  State<HeaderBarWidget> createState() => _HeaderBarWidgetState();
}

class _HeaderBarWidgetState extends State<HeaderBarWidget> {
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
