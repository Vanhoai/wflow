import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/core/http/failure.http.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/data/contract/model/request_model.dart';
import 'package:wflow/modules/main/data/task/models/create_task_model.dart';
import 'package:wflow/modules/main/data/task/models/update_task_model.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';
import 'package:wflow/modules/main/domain/task/entities/task_entity.dart';
import 'package:wflow/modules/main/domain/task/task_usecase.dart';

part 'event.dart';
part 'state.dart';

class CreateContractBloc extends Bloc<CreateContractEvent, CreateContractState> {
  final ContractUseCase contractUseCase;
  final TaskUseCase taskUseCase;

  CreateContractBloc({
    required this.contractUseCase,
    required this.taskUseCase,
  }) : super(
          CreateContractState(
            tasks: const [],
            contractEntity: ContractEntity.empty(),
          ),
        ) {
    on<CreateContractInitEvent>(onInit);
    on<AddTaskCreateContractEvent>(onAddTask);
    on<RemoveLastTaskCreateContractEvent>(onRemoveLastTask);
    on<UpdateTaskCreateContractEvent>(onUpdateTask);
    on<CreateNewContractEvent>(onCreateNewContractEvent);
    on<ContractCreatedWorkerSignEvent>(onWorkerSign);
    on<ContractCreatedBusinessSignEvent>(onBusinessSign);
  }

  FutureOr<void> onInit(CreateContractInitEvent event, Emitter<CreateContractState> emit) async {
    final response = await contractUseCase.candidateAppliedDetail(event.contract);
    response.fold(
      (ContractEntity contractEntity) {
        print('Tasks: ${contractEntity.tasks.length}');
        emit(state.copyWith(
          contractEntity: contractEntity,
          initSuccess: true,
          tasks: contractEntity.tasks,
        ));
      },
      (Failure failure) {
        AlertUtils.showMessage('Create Contract', failure.message);
        instance.get<NavigationService>().pop();
      },
    );
  }

  void onAddTask(AddTaskCreateContractEvent event, Emitter<CreateContractState> emit) async {
    final response = await taskUseCase.addTaskToContract(
      CreateTaskModel(
        contract: state.contractEntity.id,
        title: 'Simple Task',
        content: '',
        startTime: 0,
        endTime: 0,
      ),
    );

    response.fold(
      (TaskEntity taskEntity) {
        final List<TaskEntity> tasks = [...state.tasks];
        tasks.add(taskEntity);
        emit(state.copyWith(tasks: tasks));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
      },
    );
  }

  void onRemoveLastTask(RemoveLastTaskCreateContractEvent event, Emitter<CreateContractState> emit) async {
    final response = await taskUseCase.deleteTaskInContract(state.tasks.last.id.toString());

    response.fold(
      (String message) {
        emit(state.copyWith(tasks: state.tasks.sublist(0, state.tasks.length - 1)));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
      },
    );
  }

  void onUpdateTask(UpdateTaskCreateContractEvent event, Emitter<CreateContractState> emit) async {
    final response = await taskUseCase.updateTaskInContract(UpdateTaskModel(
      id: event.id,
      title: event.title,
      content: event.content,
      startTime: event.startTime,
      endTime: event.endTime,
    ));

    response.fold(
      (TaskEntity taskEntity) {
        final List<TaskEntity> tasks = [...state.tasks];
        tasks[event.index] = taskEntity;
        emit(state.copyWith(tasks: tasks));
      },
      (Failure failure) {
        AlertUtils.showMessage('Notification', failure.message);
      },
    );
  }

  FutureOr<void> onCreateNewContractEvent(CreateNewContractEvent event, Emitter<CreateContractState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());
    final response = await contractUseCase.createContract(
      CreateContractModel(
        contract: event.contract,
        title: event.title,
        content: event.description,
        salary: event.budget,
      ),
    );

    response.fold(
      (String message) {
        AlertUtils.showMessage(
          'Update Contract',
          message,
          callback: () {
            instance.get<NavigationService>().popUntil(2);
          },
        );
      },
      (Failure failure) {
        AlertUtils.showMessage('Create Contract', failure.message);
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr<void> onWorkerSign(ContractCreatedWorkerSignEvent event, Emitter<CreateContractState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final response = await contractUseCase.workerSignContract(state.contractEntity.id);
    response.fold(
      (String messages) {
        AlertUtils.showMessage(
          'Update Contract',
          messages,
          callback: () {
            instance.get<NavigationService>().popUntil(2);
          },
        );
      },
      (Failure failure) {
        AlertUtils.showMessage('Create Contract', failure.message);
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  FutureOr<void> onBusinessSign(ContractCreatedBusinessSignEvent event, Emitter<CreateContractState> emit) async {
    instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

    final response = await contractUseCase.businessSignContract(state.contractEntity.id);
    response.fold(
      (String messages) {
        AlertUtils.showMessage(
          'Update Contract',
          messages,
          callback: () {
            instance.get<NavigationService>().popUntil(2);
          },
        );
      },
      (Failure failure) {
        AlertUtils.showMessage('Create Contract', failure.message);
      },
    );

    instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
