import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wflow/core/theme/colors.dart';

class BudgetWidget extends StatelessWidget {
  final String budget;

  const BudgetWidget({required this.budget, super.key});

  @override
  Widget build(BuildContext context) {
    final noSimbolInUSFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
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
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              fontSize: 18,
            )),
          ),
          const SizedBox(height: 13.0),
          Text(
            '${noSimbolInUSFormat.format(int.parse(budget))} VNĐ',
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
