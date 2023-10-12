import 'package:flutter/material.dart';

class CandidateCVWidget extends StatelessWidget {
  const CandidateCVWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.only(top: 22, bottom: 17),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '# CV',
              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 530,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
