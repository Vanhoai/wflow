import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.text = '',
    this.onBack,
    this.onTap,
    this.actionTitle,
  });

  final Function? onBack;
  final String text;
  final String? actionTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return AppBar(
      centerTitle: true,
      title: Text(
        text,
        style: themeData.textTheme.displayMedium,
      ),
      backgroundColor: themeData.colorScheme.background,
      surfaceTintColor: themeData.colorScheme.background,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            if (onBack != null) {
              onBack!();
            }
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppConstants.backArrow,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
      actions: onTap != null
          ? [
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(
                    actionTitle ?? 'actionTitle',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(
                        0XFF1B76FF,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
