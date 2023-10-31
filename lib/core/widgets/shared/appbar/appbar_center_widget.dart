import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

class AppBarCenterWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCenterWidget({
    super.key,
    this.leading = true,
    this.center = const SizedBox(),
    this.actions = const [],
  });

  final bool leading;
  final Widget center;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return AppBar(
      centerTitle: true,
      title: center,
      backgroundColor: themeData.colorScheme.background,
      surfaceTintColor: themeData.colorScheme.background,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            alignment: Alignment.center,
            child: leading == true
                ? SvgPicture.asset(
                    AppConstants.backArrow,
                    height: 24,
                    width: 24,
                  )
                : const SizedBox(),
          ),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
