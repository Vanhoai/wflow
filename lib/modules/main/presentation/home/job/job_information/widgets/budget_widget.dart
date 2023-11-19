import 'package:flutter/material.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
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
            '🪙 ${instance.get<AppLocalization>().translate("budget")}',
            style: themeData.textTheme.displayLarge!.merge(TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
            )),
          ),
          const SizedBox(height: 13.0),
          Text(
            instance.get<ConvertString>().moneyFormat(value: budget),
            style: themeData.textTheme.displayLarge!.merge(const TextStyle(
              fontSize: 18,
            )),
          ),
        ],
      ),
    );
  }
}
