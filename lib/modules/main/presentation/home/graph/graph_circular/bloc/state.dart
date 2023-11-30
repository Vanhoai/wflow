import 'package:equatable/equatable.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}


class GraphState extends Equatable{
  final List<ChartData> chartData;

  const GraphState({required this.chartData});
  
  GraphState copyWith({List<ChartData>? chartData}){
    return GraphState(chartData: chartData ?? this.chartData);
  }

  @override
  List<Object?> get props => [chartData];
}