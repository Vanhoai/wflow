import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/utils/string.util.dart';
import 'package:wflow/core/widgets/shared/cupertino_menu/cupertino_menu.dart';

class JobCard extends StatefulWidget {
  const JobCard({
    super.key,
    this.boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    this.header = const SizedBox(),
    this.duration = 'No information',
    this.cost = '\$0',
    required this.description,
    this.bottomChild,
    this.poster = 'The Flow (tvhoai241223@gmail.com)',
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.cardPressed,
    this.isHorizontal = false,
    required this.jobId,
    required this.time,
    this.paymentAvailable = false,
  });

  final Widget header;
  final String duration;
  final String cost;
  final Widget description;
  final Widget? bottomChild;
  final Decoration boxDecoration;
  final String poster;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Function()? cardPressed;
  final bool isHorizontal;
  final num jobId;
  final DateTime time;
  final bool paymentAvailable;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  late List<String> staticTitle;

  @override
  void initState() {
    staticTitle = [
      '⏰ ${instance.get<AppLocalization>().translate("duration")}',
      '💰 ${instance.get<AppLocalization>().translate("budget")}',
      '📘 ${instance.get<AppLocalization>().translate("description")}',
      '📅 ${instance.get<AppLocalization>().translate("updatedAt")}'
    ];
    super.initState();
  }

  kSpaceVertical(BuildContext context, {double? height}) => SizedBox(height: height ?? 8);

  Widget _buildBottomChildren(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          staticTitle[3],
          style: themeData.textTheme.displayMedium,
        ),
        Text(
          instance.get<ConvertString>().timeFormat(value: widget.time),
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.displaySmall!.merge(
                const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
          maxLines: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return PostMenu(
      jobId: widget.jobId,
      margin: widget.margin,
      child: Container(
        decoration: widget.boxDecoration,
        padding: widget.padding,
        margin: widget.margin,
        child: InkWell(
          onTap: widget.cardPressed,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.zero,
            color: themeData.colorScheme.background,
            elevation: 0,
            surfaceTintColor: themeData.colorScheme.background,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.header,
                kSpaceVertical(context, height: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            staticTitle[0],
                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                              color: themeData.colorScheme.onBackground,
                            )),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.duration,
                          style: themeData.textTheme.displayMedium!.merge(
                            TextStyle(
                              color: themeData.colorScheme.onBackground,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            staticTitle[1],
                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                              color: themeData.colorScheme.onBackground,
                            )),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.cost,
                          style: themeData.textTheme.displayMedium!.merge(
                            TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                kSpaceVertical(context, height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    Text(
                      staticTitle[2],
                      style: themeData.textTheme.displayMedium!.merge(
                        TextStyle(
                          color: themeData.colorScheme.onBackground,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    widget.description,
                  ],
                ),
                const Spacer(),
                widget.bottomChild ?? _buildBottomChildren(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
