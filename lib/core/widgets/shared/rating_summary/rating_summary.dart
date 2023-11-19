import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/them.dart';

class RatingSummary extends StatelessWidget {
  const RatingSummary({
    Key? key,
    required this.counter,
    this.average = 0.0,
    this.showAverage = true,
    this.averageStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 40,
    ),
    this.counterFiveStars = 0,
    this.counterFourStars = 0,
    this.counterThreeStars = 0,
    this.counterTwoStars = 0,
    this.counterOneStars = 0,
    this.labelCounterFiveStars = '5',
    this.labelCounterFourStars = '4',
    this.labelCounterThreeStars = '3',
    this.labelCounterTwoStars = '2',
    this.labelCounterOneStars = '1',
    this.label = 'Ratings',
    this.color = Colors.amber,
    this.backgroundColor = const Color(0xFFEEEEEE),
  }) : super(key: key);

  final int counter;
  final double average;
  final bool showAverage;
  final TextStyle averageStyle;
  final int counterFiveStars;
  final int counterFourStars;
  final int counterThreeStars;
  final int counterTwoStars;
  final int counterOneStars;
  final String labelCounterFiveStars;
  final String labelCounterFourStars;
  final String labelCounterThreeStars;
  final String labelCounterTwoStars;
  final String labelCounterOneStars;
  final String label;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Column(
              children: [
                ReviewBar(
                  label: labelCounterFiveStars,
                  value: counterFiveStars == 0 ? 0 : counterFiveStars / counter,
                  color: color,
                  backgroundColor: backgroundColor,
                ),
                ReviewBar(
                  label: labelCounterFourStars,
                  value: counterFourStars == 0 ? 0 : counterFourStars / counter,
                  color: color,
                  backgroundColor: backgroundColor,
                ),
                ReviewBar(
                  label: labelCounterThreeStars,
                  value: counterThreeStars == 0 ? 0 : counterThreeStars / counter,
                  color: color,
                  backgroundColor: backgroundColor,
                ),
                ReviewBar(
                  label: labelCounterTwoStars,
                  value: counterTwoStars == 0 ? 0 : counterTwoStars / counter,
                  color: color,
                  backgroundColor: backgroundColor,
                ),
                ReviewBar(
                  label: labelCounterOneStars,
                  value: counterOneStars == 0 ? 0 : counterOneStars / counter,
                  color: color,
                  backgroundColor: backgroundColor,
                ),
              ],
            ),
          ),
          if (showAverage) ...[
            24.horizontalSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(average.toStringAsFixed(1), style: averageStyle),
                RatingBarIndicator(
                  rating: average,
                  itemSize: 28,
                  unratedColor: backgroundColor,
                  itemBuilder: (context, index) {
                    return Icon(Icons.star, color: color);
                  },
                ),
                12.verticalSpace,
                Text(
                  '$counter $label',
                  style: themeData.textTheme.displayMedium,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class ReviewBar extends StatelessWidget {
  const ReviewBar({
    Key? key,
    required this.label,
    required this.value,
    this.color = Colors.amber,
    this.backgroundColor = const Color(0xFFEEEEEE),
  }) : super(key: key);

  final String label;
  final double value;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          12.horizontalSpace,
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 12.h,
                child: LinearProgressIndicator(
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: backgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
