import 'package:flutter/material.dart';

class SliderRange extends StatefulWidget {
  const SliderRange({super.key, this.onChangeEnd, this.onChangeStart});

  final Function(RangeValues values)? onChangeEnd;
  final Function(RangeValues values)? onChangeStart;

  @override
  State<SliderRange> createState() => _SliderRangeState();
}

class _SliderRangeState extends State<SliderRange> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      onChanged: (RangeValues values) => setState(() => _currentRangeValues = values),
      min: 0,
      max: 100,
      activeColor: Theme.of(context).colorScheme.primary,
      divisions: 100,
      inactiveColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      key: widget.key,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      overlayColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      onChangeEnd: widget.onChangeEnd,
      onChangeStart: widget.onChangeStart,
    );
  }
}
