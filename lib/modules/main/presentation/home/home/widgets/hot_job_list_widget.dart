import 'package:flutter/material.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class HowJobListWidget extends StatefulWidget {
  const HowJobListWidget({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<HowJobListWidget> createState() => _HowJobListWidgetState();
}

class _HowJobListWidgetState extends State<HowJobListWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = widget.scrollController;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  void pressCard() {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen);
  }

  void pressSubTitle() {
    Navigator.pushNamed(context, RouteKeys.companyScreen);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 255),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => const SizedBox(width: 16.0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0),
              itemBuilder: (context, index) {
                return Container(
                  width: constraints.maxWidth * 0.8,
                  height: constraints.maxHeight,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: JobCard(
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
                    cardPressed: pressCard,
                    padding: const EdgeInsets.all(12),
                    header: Header(
                      title: Text('Google LLC',
                          style: themeData.textTheme.displayLarge!.merge(TextStyle(
                            fontSize: 18,
                            color: themeData.colorScheme.onBackground,
                          ))),
                      subtitle: InkWell(
                        onTap: () => pressSubTitle(),
                        child: Text('google',
                            style: themeData.textTheme.displayMedium!.merge(TextStyle(
                              color: themeData.colorScheme.onBackground.withOpacity(0.5),
                            ))),
                      ),
                      onTapTitle: () {},
                      onTapLeading: () {},
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
                    ],
                    cost: '1000\$',
                    duration: '1 month',
                    description: TextMore(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      trimMode: TrimMode.Hidden,
                      trimHiddenMaxLines: 2,
                      style: themeData.textTheme.displaySmall!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
                    ),
                  ),
                );
              },
              itemCount: 10,
            );
          },
        ),
      ),
    );
  }
}
