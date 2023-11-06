import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class ChartData {
  ChartData(this.x, this.y);

  final double x;
  final double y;
}

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: const AppHeader(text: 'Graph Works'),
      body: SizedBox(
        height: 300.h,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: ChartTitle(text: 'The number of new work in 2023'),
          primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            interval: 1,
          ),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            minimum: 0,
            maximum: 100,
            interval: 20,
            majorTickLines: const MajorTickLines(size: 0),
            axisLine: const AxisLine(width: 1),
          ),
          series: <SplineSeries<ChartData, num>>[
            SplineSeries<ChartData, num>(
              splineType: SplineType.natural,
              dataSource: <ChartData>[
                ChartData(1, 21),
                ChartData(2, 24),
                ChartData(3, 36),
                ChartData(4, 38),
                ChartData(5, 54),
                ChartData(6, 57),
                ChartData(7, 70),
                ChartData(8, 75),
                ChartData(9, 80),
                ChartData(10, 23),
                ChartData(11, 77),
                ChartData(12, 45),
              ],
              xValueMapper: (ChartData sales, _) => sales.x,
              yValueMapper: (ChartData sales, _) => sales.y,
              width: 2,
              color: AppColors.primary,
            )
          ],
          tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
        ),
      ),
    );
  }
}
