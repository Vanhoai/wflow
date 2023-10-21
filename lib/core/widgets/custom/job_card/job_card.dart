import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

const String _kProgress = '\u2022';

const List<String> staticTitle = [
  '# Duration',
  'No information',
  '# Description',
  '# Skills',
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
    this.showMore = false,
    this.labelSkill = false,
    this.skill = const [],
    this.showMoreDuration = const Duration(milliseconds: 300),
    this.bottomChild,
    this.poster = 'The Flow (tvhoai241223@gmail.com)',
    this.progress = const [],
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.skillCallback,
    this.cardPressed,
  });

  final Widget header;
  final String duration;
  final String cost;
  final TextMore description;
  final bool showMore;
  final Widget? bottomChild;
  final Decoration boxDecoration;
  final Duration showMoreDuration;
  final bool labelSkill;
  final List<String> skill;
  final String poster;
  final List<String> progress;
  final EdgeInsets padding;
  final EdgeInsets margin;

  final Function(String)? skillCallback;
  final Function()? cardPressed;
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
          'Update 2 seconds ago',
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.displaySmall!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
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

    return InkWell(
      onTap: widget.cardPressed,
      child: Container(
        decoration: widget.boxDecoration,
        padding: widget.padding,
        margin: widget.margin,
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
                  const SizedBox(height: 4),
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
              widget.labelSkill ? kSpaceVertical(context) : const SizedBox(),
              widget.labelSkill
                  ? Text(
                      staticTitle[3],
                      style: themeData.textTheme.displayMedium!.merge(
                        TextStyle(
                          color: themeData.colorScheme.onBackground,
                        ),
                      ),
                    )
                  : const SizedBox(),
              kSpaceVertical(context),
              Builder(
                builder: (context) {
                  if (widget.skill.isEmpty) return const SizedBox();
                  return SizedBox(
                    height: 32,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.skill.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (widget.skillCallback != null) {
                              widget.skillCallback!(widget.skill[index]);
                            }
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: themeData.colorScheme.onBackground.withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                            width: 72,
                            height: 32,
                            child: Center(
                              child: Text(
                                widget.skill[index],
                                style: themeData.textTheme.displaySmall!.merge(
                                  TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Builder(
                builder: (context) {
                  if (widget.showMore) {
                    return ExploreCardTile(
                      duration: widget.showMoreDuration,
                      children: [
                        kSpaceVertical(context),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              staticTitle[4],
                              style: themeData.textTheme.displayMedium!.merge(
                                TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                ),
                              ),
                            ),
                            kSpaceVertical(context),
                            Text(
                              widget.poster,
                              style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                color: themeData.colorScheme.onBackground,
                              )),
                            ),
                            kSpaceVertical(context),
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize: MaterialStateProperty.all(Size.zero),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Connect',
                                style: themeData.textTheme.displayMedium!.merge(
                                  const TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        kSpaceVertical(context),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              staticTitle[5],
                              style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                color: themeData.colorScheme.onBackground,
                              )),
                            ),
                            kSpaceVertical(context),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.progress.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Text(
                                      _kProgress,
                                      style: themeData.textTheme.displayMedium!.merge(
                                        TextStyle(
                                          color: themeData.colorScheme.onBackground,
                                        ),
                                      ),
                                    ),
                                    kSpaceVertical(context),
                                    Expanded(
                                      child: Text(
                                        widget.progress[index],
                                        style: themeData.textTheme.displayMedium!.merge(
                                          TextStyle(
                                            color: themeData.colorScheme.onBackground,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              separatorBuilder: (BuildContext context, int index) => kSpaceVertical(context),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              Builder(
                builder: (context) {
                  if (!widget.showMore) {
                    return const Expanded(child: SizedBox());
                  }
                  return const SizedBox();
                },
              ),
              widget.bottomChild ?? _buildBottomChildren(context),
            ],
          ),
        ),
      ),
    );
  }
}
