import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/string.util.dart';

class BudgetWidget extends StatelessWidget {
  final String budget;

  const BudgetWidget({required this.budget, super.key});

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
            '🪙 Budget',
            style: themeData.textTheme.displayLarge!.merge(TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
            )),
          ),
          6.verticalSpace,
          Text(
            instance.get<ConvertString>().moneyFormat(value: budget),
            style: themeData.textTheme.displayLarge!.merge(const TextStyle(
              color: AppColors.greenColor,
              fontSize: 18,
            )),
          ),
        ],
      ),
    );
  }
}
