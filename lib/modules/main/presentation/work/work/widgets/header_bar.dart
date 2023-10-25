import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_with_logo.dart';

class HeaderBarWidget extends StatefulWidget {
  const HeaderBarWidget({super.key});

  @override
  State<HeaderBarWidget> createState() => _HeaderBarWidgetState();
}

class _HeaderBarWidgetState extends State<HeaderBarWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return AppBarWithLogo(
      actions: [
        InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed(RouteKeys.searchWorkScreen),
          child: SvgPicture.asset(
            AppConstants.search,
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed(RouteKeys.notificationScreen),
          child: SvgPicture.asset(
            AppConstants.ic_notification,
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
