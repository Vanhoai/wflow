import 'package:flutter/material.dart';

class DescWidget extends StatelessWidget {
  final String description;
  const DescWidget({required this.description,super.key});

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
            '# Description',
            style: themeData.textTheme.displayLarge!.merge(TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              fontSize: 18,
            )),
          ),
          const SizedBox(height: 13.0),
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
