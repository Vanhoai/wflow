import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class ReputationScreen extends StatefulWidget {
  const ReputationScreen({super.key});

  @override
  State<ReputationScreen> createState() => _ReputationScreenState();
}

class _ReputationScreenState extends State<ReputationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      appBar: const AppBarCenterWidget(center: Text('Reputation')),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rating are verified by Wflow. You can rate your experience with other users.',
              style: themeData.textTheme.displayLarge!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            8.verticalSpace,
            const Center(
              child: RatingSummary(
                counter: 100,
                label: 'Total Rating',
                average: 4.5,
                averageStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                counterOneStars: 5,
                counterTwoStars: 5,
                counterThreeStars: 10,
                counterFourStars: 30,
                counterFiveStars: 50,
                color: AppColors.primary,
              ),
            ),
            4.verticalSpace,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Header(
                      title: const Text('User Name'),
                      subtitle: const Text('10/12/2023'),
                      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
                    ),
                    4.verticalSpace,
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: AppColors.primary,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                      glow: false,
                      itemSize: 16,
                      tapOnlyMode: false,
                      ignoreGestures: true,
                    ),
                    4.verticalSpace,
                    TextMore(
                      "You are a great person to work with. I would like to work with you again. I'ld recommend you to my friends. Very professional and friendly. You are a great person to work with. I would like to work with you again. I'ld recommend you to my friends. Very professional and friendly. You are a great person to work with. I would like to work with you again. I'ld recommend you to my friends. Very professional and friendly. You are a great person to work with. I would like to work with you again. I'ld recommend you to my friends. Very professional and friendly. You are a great person to work with. I would like to work with you again. I'ld recommend you to my friends. Very professional and friendly. ",
                      style: themeData.textTheme.displayMedium!,
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('10', style: themeData.textTheme.displayMedium),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
                        4.horizontalSpace,
                        Text('2', style: themeData.textTheme.displayMedium),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_down)),
                      ],
                    ),
                    12.verticalSpace,
                  ],
                );
              },
              itemCount: 4,
            ),
          ],
        ),
      ),
    );
  }
}
