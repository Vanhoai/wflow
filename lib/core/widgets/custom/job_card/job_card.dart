import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

const String _kProgress = '\u2022';
const List<String> mockProgress = [
  'Set up project both backend and front end',
  'Design mockup application',
  'Deploy mobile application to app store',
];
const List<String> mockTitle = [
  'Duration',
  'No information',
  'Description',
  'Skill',
  'Poster',
  'Progress',
];

const List<String> mockSkill = [
  'Flutter',
  'Dart',
  'Firebase',
  'NodeJS',
  'ExpressJS',
];

class JobCard extends StatefulWidget {
  const JobCard({
    super.key,
    this.boxDecoration = const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
    this.header = const SizedBox(),
    this.durationContent = 'No information',
    this.costContent = '\$0',
    this.descriptionContent = 'No information',
    this.listSkill = mockSkill,
    this.showMore = false,
    this.showMoreDuration = const Duration(milliseconds: 300),
    this.bottomChild = const SizedBox(),
    this.posterContent = 'The Flow (tvhoai241223@gmail.com)',
    this.progressContent = mockProgress,
  });

  final Widget header;
  final String durationContent;
  final String costContent;
  final String descriptionContent;
  final bool showMore;
  final Widget? bottomChild;
  final Decoration boxDecoration;
  final Duration showMoreDuration;
  final List<String> listSkill;
  final String posterContent;
  final List<String> progressContent;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  void initState() {
    super.initState();
  }

  kSpaceVertical(BuildContext context, {double? height}) => SizedBox(height: height ?? 8);

  Widget _buildDuration(BuildContext context, ThemeData themeData) {
    final TextStyle titleStyle = themeData.textTheme.displayLarge!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));
    final TextStyle contentStyle = themeData.textTheme.displayMedium!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(mockTitle[0], style: titleStyle),
            ),
            Text(widget.durationContent, style: contentStyle),
          ],
        ),
        kSpaceVertical(context, height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(mockTitle[1], style: titleStyle),
            ),
            Text(widget.costContent, style: contentStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, ThemeData themeData) {
    final TextStyle titleStyle = themeData.textTheme.displayLarge!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));
    final TextStyle contentStyle = themeData.textTheme.displayMedium!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      verticalDirection: VerticalDirection.down,
      children: [
        Text(mockTitle[2], style: titleStyle),
        kSpaceVertical(context, height: 2),
        TextMore(
          data: widget.descriptionContent,
          trimMode: TrimMode.None,
          style: contentStyle,
        ),
      ],
    );
  }

  Widget _buildSkill(BuildContext context, ThemeData themeData) {
    final TextStyle titleStyle = themeData.textTheme.displayLarge!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));
    final TextStyle contentStyle = themeData.textTheme.displayMedium!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          mockTitle[3],
          style: titleStyle,
        ),
        kSpaceVertical(context),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.listSkill
              .map((e) => ChipCustom(
                    title: e.toString(),
                    onTap: () {},
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPoster(BuildContext context, ThemeData themeData) {
    final TextStyle titleStyle = themeData.textTheme.displayLarge!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));
    final TextStyle contentStyle = themeData.textTheme.displayMedium!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));
    final TextStyle buttonConnectStyle = themeData.textTheme.displayMedium!.merge(TextStyle(
      color: Theme.of(context).colorScheme.primary,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(mockTitle[4], style: titleStyle),
        kSpaceVertical(context),
        Text(widget.posterContent, style: contentStyle),
        kSpaceVertical(context),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          child: Text('Connect', style: buttonConnectStyle),
        ),
      ],
    );
  }

  Widget _buildProgress(BuildContext context, ThemeData themeData) {
    final TextStyle titleStyle = themeData.textTheme.displayLarge!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));
    final TextStyle contentStyle = themeData.textTheme.displayMedium!.merge(TextStyle(
      color: Theme.of(context).colorScheme.background,
    ));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(mockTitle[5], style: titleStyle),
        kSpaceVertical(context),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.progressContent.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Text(_kProgress, style: contentStyle),
                kSpaceVertical(context),
                Expanded(
                  child: Text(widget.progressContent[index], style: contentStyle),
                ),
              ],
            );
          },
          clipBehavior: Clip.antiAliasWithSaveLayer,
          separatorBuilder: (BuildContext context, int index) => kSpaceVertical(context),
        ),
      ],
    );
  }

  Widget _buildBottomChildren(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(Icons.check_box, color: Colors.green),
              Text('Payment variable', style: TextStyle(color: Colors.green), textAlign: TextAlign.start),
            ],
          ),
        ),
        Expanded(
          child: Text('Update 2 seconds ago', textAlign: TextAlign.end),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Card(
      key: widget.key,
      color: Theme.of(context).colorScheme.error,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          textDirection: TextDirection.ltr,
          children: [
            widget.header,
            _buildDuration(context, themeData),
            kSpaceVertical(context),
            _buildDescription(context, themeData),
            kSpaceVertical(context),
            _buildSkill(context, themeData),
            kSpaceVertical(context),
            widget.showMore
                ? ExploreCardTile(
                    bottomChild: widget.bottomChild ?? _buildBottomChildren(context),
                    duration: widget.showMoreDuration,
                    children: [
                      _buildPoster(context, themeData),
                      kSpaceVertical(context),
                      _buildProgress(context, themeData),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
