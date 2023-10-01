import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

const String _kProgress = '\u2022';
const List<String> staticProgress = [
  'Set up project both backend and front end',
  'Design mockup application',
  'Deploy mobile application to app store',
];
const List<String> staticTitle = [
  'Duration',
  'No information',
  'Description',
  'Skill',
  'Poster',
  'Progress',
];

const List<String> staticSkill = [
  'Flutter',
  'Dart',
  'Firebase',
  'NodeJS',
  'ExpressJS',
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
    this.skill = staticSkill,
    this.showMoreDuration = const Duration(milliseconds: 300),
    this.bottomChild,
    this.poster = 'The Flow (tvhoai241223@gmail.com)',
    this.progress = staticProgress,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
  });

  final Widget header;
  final String duration;
  final String cost;
  final TextMore description;
  final bool showMore;
  final Widget? bottomChild;
  final Decoration boxDecoration;
  final Duration showMoreDuration;
  final List<String> skill;
  final String poster;
  final List<String> progress;
  final EdgeInsets padding;
  final EdgeInsets margin;

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
    return const Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_box, color: Colors.green),
            Text(
              'Payment variable',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
            ),
          ],
        ),
        Text(
          'Update 2 seconds ago',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
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
      child: Card(
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: themeData.colorScheme.background,
        elevation: 0,
        surfaceTintColor: themeData.colorScheme.background,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.header,

            // * CUSTOM WIDGET
            kSpaceVertical(context),
            // * CUSTOM WIDGET

            // ! BUILD DURATION AND COST =>>>>>>>>>>>>>>>>>>>
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ! BUILD DURATION =>>>>>>>>>>>>>>>>>>>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        staticTitle[0],
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.duration,
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                // ! BUILD DURATION =>>>>>>>>>>>>>>>>>>>

                // * CUSTOM WIDGET
                kSpaceVertical(context, height: 2),
                // * CUSTOM WIDGET

                // ! BUILD COST =>>>>>>>>>>>>>>>>>>>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        staticTitle[1],
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.cost,
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
              // ! BUILD COST =>>>>>>>>>>>>>>>>>>>
            ),
            // ! BUILD DURATION AND COST =>>>>>>>>>>>>>>>>>>>

            // * CUSTOM WIDGET
            kSpaceVertical(context),
            // * CUSTOM WIDGET

            // ! BUILD DESCRIPTION =>>>>>>>>>>>>>>>>>>>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: [
                Text(staticTitle[2],
                    style: themeData.textTheme.displayLarge!.merge(TextStyle(
                      color: themeData.colorScheme.onBackground,
                    ))),
                kSpaceVertical(context, height: 2),
                widget.description,
              ],
            ),
            // ! BUILD DESCRIPTION =>>>>>>>>>>>>>>>>>>>

            // * CUSTOM WIDGET
            kSpaceVertical(context),
            // * CUSTOM WIDGET

            // ! BUILD SKILL =>>>>>>>>>>>>>>>>>>>
            Builder(
              builder: (context) {
                if (widget.skill.isEmpty) return const SizedBox();

                if (widget.skill.length > 5) widget.skill.removeRange(5, widget.skill.length);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(staticTitle[3],
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground,
                        ))),
                    kSpaceVertical(context),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: widget.skill.map((e) {
                        if (e.length > 10) e = '${e.substring(0, 10)}...';

                        return ChipCustom(
                          title: e.toString(),
                          onTap: () {},
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
            // ! BUILD SKILL =>>>>>>>>>>>>>>>>>>>

            // * CUSTOM WIDGET
            kSpaceVertical(context),
            // * CUSTOM WIDGET

            // ! BUILD EXPLORE CARD TILE =>>>>>>>>>>>>>>>>>>>
            Builder(
              builder: (context) {
                if (widget.showMore) {
                  return ExploreCardTile(
                    duration: widget.showMoreDuration,
                    children: [
                      // * CUSTOM WIDGET
                      kSpaceVertical(context),
                      // * CUSTOM WIDGET

                      // ! BUILD POSTER =>>>>>>>>>>>>>>>>>>>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(staticTitle[4],
                              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ))),

                          // * CUSTOM WIDGET
                          kSpaceVertical(context),
                          // * CUSTOM WIDGET

                          Text(widget.poster,
                              style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ))),

                          // * CUSTOM WIDGET
                          kSpaceVertical(context),
                          // * CUSTOM WIDGET

                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text('Connect',
                                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ))),
                          ),
                        ],
                      ),
                      // ! BUILD POSTER =>>>>>>>>>>>>>>>>>>>

                      // * CUSTOM WIDGET
                      kSpaceVertical(context),
                      // * CUSTOM WIDGET

                      // ! BUILD PROGRESS =>>>>>>>>>>>>>>>>>>>
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(staticTitle[5],
                              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ))),

                          // * CUSTOM WIDGET
                          kSpaceVertical(context),
                          // * CUSTOM WIDGET

                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.progress.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Text(_kProgress,
                                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ))),

                                  // * CUSTOM WIDGET
                                  kSpaceVertical(context),
                                  // * CUSTOM WIDGET

                                  Expanded(
                                    child: Text(widget.progress[index],
                                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ))),
                                  ),
                                ],
                              );
                            },
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            separatorBuilder: (BuildContext context, int index) => kSpaceVertical(context),
                          ),
                        ],
                      ),
                      // ! BUILD PROGRESS =>>>>>>>>>>>>>>>>>>>
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            // ! BUILD EXPLORE CARD TILE =>>>>>>>>>>>>>>>>>>>

            // ! BOTTOM CHILDREN =>>>>>>>>>>>>>>>>>>>
            Builder(
              builder: (context) {
                if (!widget.showMore) {
                  return const Expanded(child: SizedBox());
                }
                return const SizedBox();
              },
            ),
            widget.bottomChild ?? _buildBottomChildren(context),
            // ! BOTTOM CHILDREN =>>>>>>>>>>>>>>>>>>>
          ],
        ),
      ),
    );
  }
}
