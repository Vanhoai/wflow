import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

const List<String> staticTitle = [
  '⏰ Duration',
  '💰 Budget',
  '📘 Description',
  '📚 Skills',
  '# Poster',
  '# Progress',
];

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
  });

  final Widget header;
  final String duration;
  final String cost;
  final TextMore description;
  final Widget? bottomChild;
  final Decoration boxDecoration;
  final String poster;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Function()? cardPressed;
  final bool isHorizontal;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  void initState() {
    super.initState();
  }

  kSpaceVertical(BuildContext context, {double? height}) => SizedBox(height: height ?? 8);

  Widget _buildBottomChildren(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppConstants.checkFill,
              height: 16,
              width: 16,
              colorFilter: const ColorFilter.mode(
                Colors.greenAccent,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Payment variable',
              style: Theme.of(context).textTheme.displaySmall!.merge(
                    TextStyle(
                      color: Colors.greenAccent[800],
                      fontSize: 14,
                    ),
                  ),
              textAlign: TextAlign.start,
              maxLines: 1,
            ),
          ],
        ),
        Text(
          '⏳ 2m ago',
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

    return Container(
      decoration: widget.boxDecoration,
      padding: widget.padding,
      margin: widget.margin,
      child: InkWell(
        onTap: widget.cardPressed,
        child: Card(
          clipBehavior: Clip.none,
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
              Visibility(
                visible: widget.isHorizontal,
                replacement: const SizedBox(height: 12),
                child: Expanded(child: Container()),
              ),
              widget.bottomChild ?? _buildBottomChildren(context),
            ],
          ),
        ),
      ),
    );
  }
}
