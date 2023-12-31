import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        text,
        style: textTitle(fontWeight: FontWeight.w400, size: 16),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
