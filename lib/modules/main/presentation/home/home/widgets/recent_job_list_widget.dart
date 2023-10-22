import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class RecentJobListWidget extends StatefulWidget {
  const RecentJobListWidget({super.key});

  @override
  State<RecentJobListWidget> createState() => _RecentJobListWidgetState();
}

class _RecentJobListWidgetState extends State<RecentJobListWidget> {
  void pressCard() {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          return JobCard(
            cardPressed: pressCard,
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
              title: Text(
                'Flutter Developer',
                style: themeData.textTheme.displayLarge!.merge(TextStyle(
                  fontSize: 18,
                  color: themeData.colorScheme.onBackground,
                )),
              ),
              onTapTitle: () {},
              onTapLeading: () {},
              subtitle: Text(
                'Google',
                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                  color: themeData.colorScheme.onBackground.withOpacity(0.5),
                )),
              ),
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
              'Dart',
              'Firebase',
              'Dart',
              'Firebase',
            ],
            labelSkill: true,
            cost: '1000\$',
            duration: '1 month',
            description: TextMore(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: themeData.textTheme.displayMedium!.merge(
                TextStyle(
                  color: themeData.colorScheme.onBackground,
                ),
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
