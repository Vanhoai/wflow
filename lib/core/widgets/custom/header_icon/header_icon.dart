import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/core/theme/colors.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key, required this.icon, this.onTap});

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColors.borderColor,
          ),
        ),
        child: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            themeData.textTheme.displayMedium!.color!.withOpacity(0.3),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
