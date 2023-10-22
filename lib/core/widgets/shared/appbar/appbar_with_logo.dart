import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

class AppBarWithLogo extends StatelessWidget {
  const AppBarWithLogo({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppConstants.icLogo,
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 12),
              Text(
                'WFlow',
                style: themeData.textTheme.titleLarge!.merge(
                  const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: actions ?? [],
          ),
        ],
      ),
    );
  }
}
