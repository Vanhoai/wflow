import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/graph/graph_circular/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/graph/graph_circular/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/graph/graph_circular/bloc/state.dart';

class GraphCircularWidget extends StatefulWidget {
  const GraphCircularWidget({super.key});

  @override
  State<GraphCircularWidget> createState() => _GraphCircularWidgetState();
}

class _GraphCircularWidgetState extends State<GraphCircularWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GraphBloc(postUseCase: instance.get<PostUseCase>())..add(GetGraph()),
      child: BlocBuilder<GraphBloc, GraphState>(
        builder: (context, state) {
          return SizedBox(
            height: 200.h,
            width: MediaQuery.of(context).size.width,
            child: SfCircularChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.right,
                shouldAlwaysShowScrollbar: false,
              ),
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                    dataSource: state.chartData,
                    enableTooltip: true,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    // Segments will explode on tap
                    explode: true,
                    // First segment will be exploded on initial rendering
                    explodeIndex: 1,
                    dataLabelSettings: const DataLabelSettings(isVisible: true)),
              ],
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          );
        },
      ),
    );
  }
}
