import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    this.labelCounterFiveStarsStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.labelCounterFourStarsStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.labelCounterThreeStarsStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.labelCounterTwoStarsStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.labelCounterOneStarsStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.label = 'Ratings',
    this.labelStyle = const TextStyle(fontWeight: FontWeight.w600),
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
  final TextStyle labelCounterFiveStarsStyle;
  final TextStyle labelCounterFourStarsStyle;
  final TextStyle labelCounterThreeStarsStyle;
  final TextStyle labelCounterTwoStarsStyle;
  final TextStyle labelCounterOneStarsStyle;
  final String label;
  final TextStyle labelStyle;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ReviewBar(
                label: labelCounterFiveStars,
                labelStyle: labelCounterFiveStarsStyle,
                value: counterFiveStars / counter,
                color: color,
                backgroundColor: backgroundColor,
              ),
              _ReviewBar(
                label: labelCounterFourStars,
                labelStyle: labelCounterFourStarsStyle,
                value: counterFourStars / counter,
                color: color,
                backgroundColor: backgroundColor,
              ),
              _ReviewBar(
                label: labelCounterThreeStars,
                labelStyle: labelCounterThreeStarsStyle,
                value: counterThreeStars / counter,
                color: color,
                backgroundColor: backgroundColor,
              ),
              _ReviewBar(
                label: labelCounterTwoStars,
                labelStyle: labelCounterTwoStarsStyle,
                value: counterTwoStars / counter,
                color: color,
                backgroundColor: backgroundColor,
              ),
              _ReviewBar(
                label: labelCounterOneStars,
                labelStyle: labelCounterOneStarsStyle,
                value: counterOneStars / counter,
                color: color,
                backgroundColor: backgroundColor,
              ),
            ],
          ),
        ),
        if (showAverage) ...[
          const SizedBox(width: 30),
          Flexible(
            child: Column(
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
                const SizedBox(height: 10),
                Text(
                  '$counter $label',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ReviewBar extends StatelessWidget {
  const _ReviewBar({
    Key? key,
    required this.label,
    required this.value,
    this.color = Colors.amber,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.labelStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  }) : super(key: key);
  final String label;
  final TextStyle labelStyle;
  final double value;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: labelStyle,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 10,
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
