import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';

part 'event.dart';
part 'state.dart';

class CreateContractBloc extends Bloc<CreateContractEvent, CreateContractState> {
  final ContractUseCase contractUseCase;

  CreateContractBloc({required this.contractUseCase}) : super(const CreateContractState()) {
    on<CreateContractInitEvent>(onInit);
    on<AddTaskCreateContractEvent>(onAddTask);
    on<RemoveLastTaskCreateContractEvent>(onRemoveLastTask);
    on<UpdateTaskCreateContractEvent>(onUpdateTask);
  }

  FutureOr<void> onInit(CreateContractInitEvent event, Emitter<CreateContractState> emit) async {}

  void onAddTask(AddTaskCreateContractEvent event, Emitter<CreateContractState> emit) {
    emit(state.copyWith(
      tasks: [
        ...state.tasks,
        const TaskCreateContractModel(
          endTime: 0,
          startTime: 0,
          title: 'Simple task',
          content: '',
        )
      ],
    ));
  }

  void onRemoveLastTask(RemoveLastTaskCreateContractEvent event, Emitter<CreateContractState> emit) {
    if (state.tasks.isNotEmpty) {
      emit(state.copyWith(tasks: state.tasks.sublist(0, state.tasks.length - 1)));
    }
  }

  void onUpdateTask(UpdateTaskCreateContractEvent event, Emitter<CreateContractState> emit) {
    final tasks = state.tasks;
    tasks[event.index] = tasks[event.index].copyWith(
      title: event.title,
      content: event.content,
      startTime: event.startTime,
      endTime: event.endTime,
    );
    emit(state.copyWith(tasks: tasks));
  }
}
