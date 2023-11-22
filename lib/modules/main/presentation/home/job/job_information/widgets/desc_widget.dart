import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class DescWidget extends StatelessWidget {
  final String description;
  const DescWidget({required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<String> desc = description.split('.');

    desc.removeWhere((element) => element.isEmpty);

    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '📘 ${instance.get<AppLocalization>().translate("description")}',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: themeData.textTheme.displayLarge!.merge(
              TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18,
              ),
            ),
          ),
          6.verticalSpace,
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 4.w),
              itemBuilder: (context, index) {
                return TextMore(
                  '⦁ ${desc[index].trim()}',
                  style: themeData.textTheme.displayLarge!.merge(TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 16,
                  )),
                  trimMode: TrimMode.Line,
                  trimLines: 7,
                );
              },
              itemCount: desc.length,
            ),
          ),
        ],
      ),
    );
  }
}
