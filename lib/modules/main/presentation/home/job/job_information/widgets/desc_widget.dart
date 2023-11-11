import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescWidget extends StatelessWidget {
  final String description;
  const DescWidget({required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '📘 Description',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: themeData.textTheme.displayLarge!.merge(
              TextStyle(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                fontSize: 18,
              ),
            ),
          ),
          12.verticalSpace,
          Text(
            description,
            style: themeData.textTheme.displayLarge!.merge(TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
            )),
          ),
        ],
      ),
    );
  }
}
