import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

const String _kProgress = '\u2022';

const List<String> staticTitle = [
  'Duration',
  'No information',
  'Description',
  'Skill',
  'Poster',
  'Progress',
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
  // callback
  final Function(String)? skillCallback;

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
    return const Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.check_box, color: Colors.green),
            Text(
              'Payment variable',
              style: TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.w500,
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
            fontSize: 10,
            fontWeight: FontWeight.w500,
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
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.duration,
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      )),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        staticTitle[1],
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        )),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.cost,
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      )),
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
                Text(staticTitle[2],
                    style: themeData.textTheme.displayLarge!.merge(TextStyle(
                      color: themeData.colorScheme.onBackground,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ))),
                widget.description,
              ],
            ),
            widget.labelSkill ? kSpaceVertical(context) : const SizedBox(),
            widget.labelSkill
                ? Text(staticTitle[3],
                    style: themeData.textTheme.displayLarge!.merge(TextStyle(
                      color: themeData.colorScheme.onBackground,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )))
                : const SizedBox(),
            kSpaceVertical(context),
            Builder(
              builder: (context) {
                if (widget.skill.isEmpty) return const SizedBox();
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: widget.skill.map((e) {
                    return InkWell(
                      onTap: () {
                        if (widget.skillCallback != null) {
                          widget.skillCallback!(e);
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
                        width: 54,
                        height: 20,
                        child: Center(
                          child: Text(
                            e,
                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            )),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
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
                          Text(staticTitle[4],
                              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))),
                          kSpaceVertical(context),
                          Text(widget.poster,
                              style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ))),
                          kSpaceVertical(context),
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text('Connect',
                                style: themeData.textTheme.displayMedium!.merge(const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ))),
                          ),
                        ],
                      ),
                      kSpaceVertical(context),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(staticTitle[5],
                              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))),
                          kSpaceVertical(context),
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ))),
                                  kSpaceVertical(context),
                                  Expanded(
                                    child: Text(widget.progress[index],
                                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                          color: Theme.of(context).colorScheme.onBackground,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
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
    );
  }
}
