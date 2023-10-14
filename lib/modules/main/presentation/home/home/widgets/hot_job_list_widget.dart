import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
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
    super.initState();
    _scrollController = widget.scrollController;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void pressCard() {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 360),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0),
              itemBuilder: (context, index) {
                return Container(
                  width: constraints.maxWidth * 0.8,
                  height: constraints.maxHeight,
                  margin: const EdgeInsets.only(right: 20),
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
                      title: Text(
                        'Flutter Developer',
                        style: themeData.textTheme.displayLarge!.merge(
                          TextStyle(
                            fontSize: 18,
                            color: themeData.colorScheme.onBackground,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        'Google',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(
                            color: themeData.colorScheme.onBackground.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      onTapTitle: () {},
                      onTapLeading: () {},
                      leadingSize: 30,
                      actions: [
                        InkWell(
                          child: SvgPicture.asset(
                            AppConstants.bookmark,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              themeData.colorScheme.onBackground.withOpacity(0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                    skill: const [
                      'Flutter',
                      'Dart',
                      'Firebase',
                    ],
                    labelSkill: true,
                    cost: '1000\$',
                    duration: '1 month',
                    description: TextMore(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      trimMode: TrimMode.Hidden,
                      trimHiddenMaxLines: 3,
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
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
