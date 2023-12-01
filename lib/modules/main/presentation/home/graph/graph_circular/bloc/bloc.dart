


import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/graph/graph_circular/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/graph/graph_circular/bloc/state.dart';

class GraphBloc extends Bloc<GraphEvent,GraphState>{
  final PostUseCase postUseCase;
  GraphBloc({required this.postUseCase}) : super(const GraphState(chartData: [])){
    on<GetGraph>(getGraph);
  }

  FutureOr<void> getGraph(GetGraph event, Emitter<GraphState> emit) async {
    final response = await postUseCase.getStatistic();
    List<ChartData> chartData = [];
    for (var e in response) {
      chartData.add(ChartData(e.tag, double.parse(e.count)));
    }
    emit(state.copyWith(chartData: chartData));
  }
}