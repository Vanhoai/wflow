

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/task/bloc/state.dart';

class TaskBloc extends Bloc<TaskEvent,TaskState>{
  TaskBloc():super(initState()){
    on<UpdateTaskEvent>(updateTask);
  }


  static TaskState initState(){
    final List<Task> data = [
      Task(
          id: 1,
          title: "Design database for application and set up base resouce",
          content: "Mua source",
          end: DateTime.now().toString(),
          status: "REQUEST"),
      Task(
          id: 2,
          title: "Design database for application and set up base resouce",
          content: "Mua source",
          end: DateTime.now().toString(),
          status: "REJECT"),
      Task(
          id: 3,
          title: "Viết công nghệ kéo sì zác chuẩn, bịp người dùng với tỉ lệ ổn, mang đến cho người dùng cảm giác không bị bịp",
          content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
          end: DateTime.now().toString(),
          status: "NONE"),
      Task(
          id: 4,
          title: "Design database for application and set up base resouce",
          content: "Mua source",
          end: DateTime.now().toString(),
          status: "DONE"),
      Task(
          id: 5,
          title: "Design database for application and set up base resouce",
          content: "Mua source",
          end: DateTime.now().toString(),
          status: "DONE"),
      Task(
          id: 6,
          title: "Design database for application and set up base resouce",
          content: "Mua source",
          end: DateTime.now().toString(),
          status: "DONE"),
    ];
    return TaskState(listTask: data);
  }

  FutureOr<void> updateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    state.listTask[state.listTask.indexWhere((element) => element.id == event.task.id)] = event.task;
    emit(state.copyWith(listTask: state.listTask));
  }
}