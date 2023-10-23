import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_with_logo.dart';

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
    final ThemeData themeData = Theme.of(context);

    return AppBarWithLogo(
      actions: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(RouteKeys.notificationScreen),
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
          onTap: () => Navigator.of(context).pushNamed(RouteKeys.notificationScreen),
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
