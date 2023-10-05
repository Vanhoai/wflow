import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class RecentJobListWidget extends StatefulWidget {
  const RecentJobListWidget({super.key, required this.selectionValue});

  final int selectionValue;

  @override
  State<RecentJobListWidget> createState() => _RecentJobListWidgetState();
}

class _RecentJobListWidgetState extends State<RecentJobListWidget> {
  late int selectionValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectionValue = widget.selectionValue;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          return JobCard(
            boxDecoration: BoxDecoration(
              color: themeData.colorScheme.background,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: themeData.colorScheme.onBackground.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: themeData.colorScheme.onBackground.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            header: Header(
              title: const Text(
                'Tran Van Hoai',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: const Text(
                'hoai',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leadingSize: 30,
              actions: [
                IconButton.filled(
                  icon: Icon(Icons.bookmark_add, color: themeData.colorScheme.onBackground),
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Save',
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  highlightColor: Colors.blue.withOpacity(0.5),
                ),
              ],
            ),
            skill: const [
              'Flutter',
              'Dart',
              'Firebase',
              'Dart',
              'Firebase',
              'Dart',
              'Firebase',
            ],
            labelSkill: true,
            cost: '1000\$',
            duration: '1 month',
            description: const TextMore(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              trimMode: TrimMode.Hidden,
              trimHiddenMaxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            progress: const [
              '1.5 years of experience in Flutter',
            ],
            showMore: true,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
        itemCount: 10,
      ),
    );
  }
}
